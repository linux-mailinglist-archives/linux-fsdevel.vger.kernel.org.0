Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644184C86AB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 09:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbiCAIlL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 03:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiCAIlK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:41:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482CD888D6;
        Tue,  1 Mar 2022 00:40:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FEDB6147A;
        Tue,  1 Mar 2022 08:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1134C340EE;
        Tue,  1 Mar 2022 08:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646124029;
        bh=WL/IYhFRSmf+n/SVEgXVr+y6kldvUj1aMHyALkZb0PA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=b4ziXgSG02Hlfmj6+7pwwO2SjoI0bkotabqY1PCl7pbPkrZ6DFRO72pl9Gkip/aY8
         NkEt4zSyGWpW4SlDdDxFwwCFf7aw7+pcpXK1bTYfMaDFehZPcmu83Og3Qh8jRAriOE
         RihBHWC2UdKamBfR5UR8K8540TgNbNRdfN+fI7pp52sUvcm9QcRNRCbgk6dEKt3pdE
         2Nl/GiyR0Mul5PQ4V/EmwbLoQ8AXQBsdiGhanY7mxi7wSjjNw4Nmgolj+3EJiizkJv
         aLWv+bNXIAZL3TyQMBat/OUF6rcpRPnzDGzKW1cu4jO5aolZAeKVDQrLaQZZ23OALC
         iFFppbPIxeLWQ==
Received: by mail-wr1-f43.google.com with SMTP id m6so2004795wrr.10;
        Tue, 01 Mar 2022 00:40:28 -0800 (PST)
X-Gm-Message-State: AOAM531Frb3LNDsB3R28x443ZaZxbcmmtUITc+fvVfejE6lU5KrJZmTm
        qAAwq6jilr/U/5HXt9snisZYfcsql6wUsPPNADQ=
X-Google-Smtp-Source: ABdhPJx57/Hyy0tOwGXp8yUIubw0RqZ2cDGbUQOG7BKmdDTEzN3EXrztAhBZF4H+gDOXu3QIwtZLrC6SLapXviDGTAY=
X-Received: by 2002:a5d:4ad1:0:b0:1ef:9481:f343 with SMTP id
 y17-20020a5d4ad1000000b001ef9481f343mr9552893wrs.165.1646124027296; Tue, 01
 Mar 2022 00:40:27 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a5d:4e02:0:0:0:0:0 with HTTP; Tue, 1 Mar 2022 00:40:26 -0800 (PST)
In-Reply-To: <Yh2fY6F8n/8KvMEH@google.com>
References: <20220228234833.10434-1-linkinjeon@kernel.org> <20220228234833.10434-3-linkinjeon@kernel.org>
 <Yh2fY6F8n/8KvMEH@google.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 1 Mar 2022 17:40:26 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-RutZ6m4kD6LBYGfShU+X+aQw9rhhtQQHCzC7j3hQtHg@mail.gmail.com>
Message-ID: <CAKYAXd-RutZ6m4kD6LBYGfShU+X+aQw9rhhtQQHCzC7j3hQtHg@mail.gmail.com>
Subject: Re: [PATCH 3/4] ksmbd: increment reference count of parent fp
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        smfrench@gmail.com, hyc.lee@gmail.com,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-03-01 13:21 GMT+09:00, Sergey Senozhatsky <senozhatsky@chromium.org>:
> On (22/03/01 08:48), Namjae Jeon wrote:
>> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
>> index 3151ab7d7410..03c3733e54e4 100644
>> --- a/fs/ksmbd/smb2pdu.c
>> +++ b/fs/ksmbd/smb2pdu.c
>> @@ -5764,8 +5764,10 @@ static int set_rename_info(struct ksmbd_work *work,
>> struct ksmbd_file *fp,
>>  	if (parent_fp) {
>>  		if (parent_fp->daccess & FILE_DELETE_LE) {
>>  			pr_err("parent dir is opened with delete access\n");
>> +			ksmbd_fd_put(work, parent_fp);
>>  			return -ESHARE;
>>  		}
>> +		ksmbd_fd_put(work, parent_fp);
>>  	}
>
> And also in ksmbd_validate_entry_in_use()?
ksmbd_validate_entry_in_use() is removed in 4/4 patch.
I need to change the order of the patches to avoid confusion.

Thanks!
>
>>  next:
>>  	return smb2_rename(work, fp, user_ns, rename_info,
>> diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
>> index 0974d2e972b9..c4d59d2735f0 100644
>> --- a/fs/ksmbd/vfs_cache.c
>> +++ b/fs/ksmbd/vfs_cache.c
>> @@ -496,6 +496,7 @@ struct ksmbd_file *ksmbd_lookup_fd_inode(struct inode
>> *inode)
>>  	list_for_each_entry(lfp, &ci->m_fp_list, node) {
>>  		if (inode == file_inode(lfp->filp)) {
>>  			atomic_dec(&ci->m_count);
>> +			lfp = ksmbd_fp_get(lfp);
>>  			read_unlock(&ci->m_lock);
>>  			return lfp;
>>  		}
>> --
>> 2.25.1
>>
>
