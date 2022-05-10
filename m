Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1685213BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 13:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240606AbiEJLcl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 07:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238682AbiEJLck (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 07:32:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606F524DC00;
        Tue, 10 May 2022 04:28:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F13281F8B5;
        Tue, 10 May 2022 11:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652182121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o3MNMfYAzBmcTCGWbN4PU5xoySsicFXm7oS2gQCk3PM=;
        b=1dFLSVWLYnS0PIpslKIMUpWl8LjaxLlNBHKDubjTk6onQXqgZH5a0/Z5GeUA3bHMl8xojF
        d9I2UmLnaMPoeviFv4q5kPwkzmfxbbIfOpRLTioqMuHT+8nuHt6Jhrv8iNqwa5qzA89XAj
        Lg9iWgj57Z6kYOgecr0iyuShQgkv9lc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652182121;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o3MNMfYAzBmcTCGWbN4PU5xoySsicFXm7oS2gQCk3PM=;
        b=kkU6z+n9RITqF8SMik6rIWdkljq8WB0PgIdPVNvAnPTw2Fs3gxyM+0MeKmAS3lsuTGxcti
        p/8yZNfoWEFHk2AA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DFDB72C141;
        Tue, 10 May 2022 11:28:41 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8BAB1A062A; Tue, 10 May 2022 13:28:38 +0200 (CEST)
Date:   Tue, 10 May 2022 13:28:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     butt3rflyh4ck <butterflyhuangxx@gmail.com>
Cc:     jack@suse.com, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: A slab-out-of-bounds Write when invoke udf_write_fi via ioctl
Message-ID: <20220510112838.zfx2sxyoh4ewmjxr@quack3.lan>
References: <CAFcO6XNpj6e+OGba30usr_miODhbhmqk7vh3ymU+NLoe2HBqFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFcO6XNpj6e+OGba30usr_miODhbhmqk7vh3ymU+NLoe2HBqFA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 10-05-22 15:14:42, butt3rflyh4ck wrote:
> Hi, if mounts a malicious udf image,  there is a slab out of bounds
> write  bug when a user invokes udf_write_fi via ioctl.
> I have reproduced it in the latest kernel.
> 
> ##smaple analyse
> the function call chains:
> do_sys_open
>     --->do_sys_openat2
>        --->do_filp_open
>           --->path_openat
>               --->open_last_lookups
>                  --->lookup_open
>                      --->udf_add_nondir
>                         --->udf_add_entry
> 
> There would traverse to get a `fi` in the function udf_add_entry.
> ```
> if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {   [1]
>          block = dinfo->i_location.logicalBlockNum;
>          fi = (struct fileIdentDesc *)
>            (dinfo->i_data + fibh->soffset -
>              udf_ext0_offset(dir) +
>               dinfo->i_lenEAttr);
>              [2]
> } else {
>           block = eloc.logicalBlockNum +
>               ((elen - 1) >>
>             dir->i_sb->s_blocksize_bits);
>             fi = (struct fileIdentDesc *)
>                  (fibh->sbh->b_data + fibh->soffset);
> }
> ```
> [1] if dinfo->i_alloc_type is ICBTAG_FLAG_AD_IN_ICB, [2] it  would
> calculate an offset as `fi`,
> through the debugger, the `fi` is as below:
> ```
>  p/x *(struct fileIdentDesc*)fi
> $24 = {
>   descTag = {
>     tagIdent = 0x2f70,
>     descVersion = 0xea55,
>     tagChecksum = 0xcd,
>     reserved = 0x66,
>     tagSerialNum = 0x511f,
>     descCRC = 0x5a9c,
>     descCRCLength = 0x5142,
>     tagLocation = 0x373ce06a
>   },
>   fileVersionNum = 0x3139,
>   fileCharacteristics = 0xf6,
>   lengthFileIdent = 0x7e,
>   icb = {
>     extLength = 0x6059792,
>     extLocation = {
>       logicalBlockNum = 0x73886466,
>       partitionReferenceNum = 0x7cc6
>     },
>     impUse = {0x3c, 0xcc, 0x4a, 0xed, 0xdc, 0xfb}
>   },
>   lengthOfImpUse = 0x1a6a,
>   impUse = 0xffff888019ca716a
> }
> ```
> These data are wrong and all data are part of  udf image mounted.
> Then next it would invoke function udf_write_fi to write fileident into `fi`.
> ```
> if (fileident) {
>       if (adinicb || (offset + lfi < 0)) {
>           memcpy(udf_get_fi_ident(sfi), fileident, lfi);   [3]
> } else if (offset >= 0) {
>           memcpy(fibh->ebh->b_data + offset, fileident, lfi);
> } else {
>           memcpy(udf_get_fi_ident(sfi), fileident, -offset);
>           memcpy(fibh->ebh->b_data, fileident - offset,
>                   lfi + offset);
>        }
> }
> ```
> The fileident was controlled by user. `sfi` is `fi`, the memcpy
> function is called to copy the data, so an out-of-bounds write occurs

Thanks for report and the analysis. This is indeed a serious bug. I'll send
a fix shortly.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
