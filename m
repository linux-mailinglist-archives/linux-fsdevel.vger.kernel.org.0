Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AA65365D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 18:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242925AbiE0QRb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 12:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiE0QRa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 12:17:30 -0400
X-Greylist: delayed 594 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 May 2022 09:17:29 PDT
Received: from relay5.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A322C4C40B
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 09:17:29 -0700 (PDT)
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 54528336CD;
        Fri, 27 May 2022 16:07:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id 39B3D32;
        Fri, 27 May 2022 16:07:33 +0000 (UTC)
Message-ID: <94dd870e498e89e0998dee4dd0dbaaa4b4497929.camel@perches.com>
Subject: Re: [PATCH 1/3] fs/ntfs3: Refactoring of indx_find function
From:   Joe Perches <joe@perches.com>
To:     Almaz Alexandrovich <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Fri, 27 May 2022 09:07:30 -0700
In-Reply-To: <0f9648cc-66af-077c-88e6-8650fd78f44c@paragon-software.com>
References: <75a1215a-eda2-d0dc-b962-0334356eef7c@paragon-software.com>
         <0f9648cc-66af-077c-88e6-8650fd78f44c@paragon-software.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Stat-Signature: dckefw6kzm5u1pwrkyhcm45kktryhqqf
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 39B3D32
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19VwBNuG8zVMoN9lOhktdWQ7gt5m/9IoJY=
X-HE-Tag: 1653667653-438087
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-05-27 at 17:21 +0300, Almaz Alexandrovich wrote:
> This commit makes function a bit more readable

trivia:

> diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
[]
> @@ -1042,19 +1042,16 @@ int indx_find(struct ntfs_index *indx, struct ntfs_inode *ni,
>   {
>   	int err;
>   	struct NTFS_DE *e;
> -	const struct INDEX_HDR *hdr;
>   	struct indx_node *node;
>   
>   	if (!root)
>   		root = indx_get_root(&ni->dir, ni, NULL, NULL);
>   
>   	if (!root) {
> -		err = -EINVAL;
> -		goto out;
> +		/* Should not happed. */
> +		return -EINVAL;

s/happed/happen/

>   	for (;;) {
>   		node = NULL;
>   		if (*diff >= 0 || !de_has_vcn_ex(e)) {
>   			*entry = e;
> -			goto out;
> +			return 0;
>   		}

might be nicer with a break; or a while like

	while (*diff < 0 && de_has_vcn_ex(e)) {
		node = NULL;


>   		/* Read next level. */
>   		err = indx_read(indx, ni, de_get_vbn(e), &node);
>   		if (err)
> -			goto out;
> +			return err;
>   
>   		/* Lookup entry that is <= to the search value. */
>   		e = hdr_find_e(indx, &node->index->ihdr, key, key_len, ctx,
>   			       diff);
>   		if (!e) {
> -			err = -EINVAL;
>   			put_indx_node(node);
> -			goto out;
> +			return -EINVAL;
>   		}
>   
>   		fnd_push(fnd, node, e);
>   	}
> -
> -out:
> -	return err;

and a return 0;

or
	*entry = e;
	return 0;

so it appears that the function has a typical return value.

