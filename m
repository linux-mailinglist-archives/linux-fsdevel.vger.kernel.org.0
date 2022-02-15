Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C2A4B5FE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 02:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbiBOBPW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 20:15:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiBOBPV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 20:15:21 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C3B1342C4;
        Mon, 14 Feb 2022 17:15:13 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJmQx-001q8Z-Vt; Tue, 15 Feb 2022 01:15:12 +0000
Date:   Tue, 15 Feb 2022 01:15:11 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Stefan Roesch <shr@fb.com>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 1/2] fs: replace const char* parameter in vfs_statx
 and do_statx with struct filename
Message-ID: <Ygr+nzDK6ft6LXfG@zeniv-ca.linux.org.uk>
References: <20220215002121.2049686-1-shr@fb.com>
 <20220215002121.2049686-2-shr@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215002121.2049686-2-shr@fb.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 14, 2022 at 04:21:20PM -0800, Stefan Roesch wrote:
>  {
> -	return do_statx(dfd, filename, flags, mask, buffer);
> +	int ret;
> +	struct filename *name;
> +
> +	name = getname_flags(filename, getname_statx_lookup_flags(flags), NULL);
> +	ret = do_statx(dfd, name, flags, mask, buffer);
> +	if (name)
> +		putname(name);

... and the same comment goes for this one - getname... does *not*
report a failure as NULL; it's ERR_PTR(), and putname(ERR_PTR(...))
is an explicit no-op.
