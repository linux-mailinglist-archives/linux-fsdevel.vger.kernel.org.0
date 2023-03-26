Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3ED16C9264
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Mar 2023 06:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjCZEqi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Mar 2023 00:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCZEqh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Mar 2023 00:46:37 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883A5B756;
        Sat, 25 Mar 2023 21:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wRdGMeDukOPfpIChX8oC11+lUjNcyTUDpDS6QjoKQTc=; b=hnkPa9Zevrm71mPI/eWuxQEuX2
        Iq+ahhpBqy2g5U16UNlmttYispW6PztrC2xLwdHm9Auf8OYBJww0igb+iINfJ2qV0g4qdetw3XKDT
        8Gd2eVTF3plKkb5Rsngam1DRJ8LDNKXHlUWr2grvVdGRyePybnm+1PSKcJrHr1k3xLKbGpHjSpJRY
        Z3TsNwOBGaZBfL5b3McqQ2QbF6sbaeAP+061rZZDiwFtsfZNPVIH80jnjqRbxv/ICr/wCLFUcAhYf
        1gB//SuzC54l5TEwMvQeiX5QLcXIsyjtCuKZ8S5lzvpiPGJSxCfVCXw3gIm4NbkWuq+oR/wx+SR4b
        KpZEQGGg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgIGx-0020Np-21;
        Sun, 26 Mar 2023 04:46:27 +0000
Date:   Sun, 26 Mar 2023 05:46:27 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, jaegeuk@kernel.org, ebiggers@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel@collabora.com
Subject: Re: [PATCH 3/7] libfs: Validate negative dentries in
 case-insensitive directories
Message-ID: <20230326044627.GD3390869@ZenIV>
References: <20220622194603.102655-1-krisman@collabora.com>
 <20220622194603.102655-4-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622194603.102655-4-krisman@collabora.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_FILL_THIS_FORM_SHORT autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 22, 2022 at 03:45:59PM -0400, Gabriel Krisman Bertazi wrote:

> +static inline int generic_ci_d_revalidate(struct dentry *dentry,
> +					  const struct qstr *name,
> +					  unsigned int flags)
> +{
> +	int is_creation = flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET);
> +
> +	if (d_is_negative(dentry)) {
> +		const struct dentry *parent = READ_ONCE(dentry->d_parent);
> +		const struct inode *dir = READ_ONCE(parent->d_inode);
> +
> +		if (dir && needs_casefold(dir)) {
> +			if (!d_is_casefold_lookup(dentry))
> +				return 0;

	In which conditions does that happen?

> +			if (is_creation &&
> +			    (dentry->d_name.len != name->len ||
> +			     memcmp(dentry->d_name.name, name->name, name->len)))
> +				return 0;
> +		}
> +	}
> +	return 1;
> +}

	Analysis of stability of ->d_name, please.  It's *probably* safe, but
the details are subtle and IMO should be accompanied by several asserts.
E.g. "we never get LOOKUP_CREATE in op->intent without O_CREAT in op->open_flag
for such and such reasons, and we verify that in such and such place"...

	A part of that would be "the call in lookup_dcache() can only get there
with non-zero flags when coming from __lookup_hash(), and that has parent locked,
stabilizing the name; the same goes for the call in __lookup_slow(), with the
only call chain with possibly non-zero flags is through lookup_slow(), where we
have the parent locked".  However, lookup_fast() and lookup_open() have the
flags come from nd->flags, and LOOKUP_CREATE can be found there in several areas.
I _think_ we are guaranteed the parent locked in all such call chains, but that
is definitely worth at least a comment.
