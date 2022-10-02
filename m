Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433195F2107
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Oct 2022 04:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiJBCWM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Oct 2022 22:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiJBCWL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Oct 2022 22:22:11 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AB8402EC;
        Sat,  1 Oct 2022 19:22:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 08E3FCE0934;
        Sun,  2 Oct 2022 02:22:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2478EC43144;
        Sun,  2 Oct 2022 02:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664677327;
        bh=b51DYrE7TDbzSmHbIA9G35Mls3Smyumbe5DWegWVzZo=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=chcW1+urc+hsFPPz3d5nDoBB7Gup+/e/MAmQgZMcBSXxDYXQc5Oxw4KSM1gn72pCj
         5++POfqGg4P1FeolFuqbbhMLleZ+tp0UrRPNZ7CSVCVg4Ylgz5h0untYvZBe8uyvYk
         dbTqNeZrktQskBNU3GMQwG/EGXj7dKqaLYe6A56i6dZDz3B4efaLtI/dNdKvDqd9tx
         zKYxT8+spRkXwDbMzaleb2wbzZr82cI1qvRtoGfHEDvKFCfKiUN7RVFqNbhhfjjTnZ
         5LmAblZZYDsSndHxwjcRvJjVBD7ao8sdCTjpgooDrpKJhpz8xt9pqrd2tYpPhQDJvd
         zuUXFizZFKQFg==
Received: by mail-oi1-f181.google.com with SMTP id o64so8419493oib.12;
        Sat, 01 Oct 2022 19:22:07 -0700 (PDT)
X-Gm-Message-State: ACrzQf3jI9HI4h4y1gT2BZhHNV9eDvHtRqULexjBW9LQSY4hfwiOMh7S
        UXMmKcNCWQA8wjCQHvWoQF/UeDhPlpD3JXEcXeY=
X-Google-Smtp-Source: AMsMyM5xlPIajRHtfOBge6ZdxJ1WZfkCSYzQKuPxzDFDXdgTetAttIp9+stC4ertCehIPWUatFVB+3jdtTVSAoO7U7I=
X-Received: by 2002:a05:6808:211d:b0:34f:e0fc:6e6e with SMTP id
 r29-20020a056808211d00b0034fe0fc6e6emr1948215oiw.8.1664677326338; Sat, 01 Oct
 2022 19:22:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6838:27c7:0:0:0:0 with HTTP; Sat, 1 Oct 2022 19:22:05
 -0700 (PDT)
In-Reply-To: <YzjZgB1VL69eGUfK@ZenIV>
References: <20220920224338.22217-1-linkinjeon@kernel.org> <20220920224338.22217-3-linkinjeon@kernel.org>
 <YzjZgB1VL69eGUfK@ZenIV>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sun, 2 Oct 2022 11:22:05 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-biC1nEi-KnVbpf3OtMPr0xZKbvgjXm6pYVOpM_psVhQ@mail.gmail.com>
Message-ID: <CAKYAXd-biC1nEi-KnVbpf3OtMPr0xZKbvgjXm6pYVOpM_psVhQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] fs: introduce lock_rename_child() helper
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        smfrench@gmail.com, senozhatsky@chromium.org, tom@talpey.com,
        atteh.mailbox@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-10-02 9:21 GMT+09:00, Al Viro <viro@zeniv.linux.org.uk>:
> On Wed, Sep 21, 2022 at 07:43:37AM +0900, Namjae Jeon wrote:
>
>
> FWIW, it probably needs a few comments:
I will add it on next spin.

Thanks for your review!
>
> // c1 and p2 should be on the same fs
>> +struct dentry *lock_rename_child(struct dentry *c1, struct dentry *p2)
>> +{
>> +	if (READ_ONCE(c1->d_parent) == p2) {
> 		// hopefully won't need to touch ->s_vfs_rename_mutex at all.
>> +		inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
> 		// now that p2 is locked, nobody can move in or out of it,
> 		// so the test below is safe
>> +		if (likely(c1->d_parent == p2))
>> +			return NULL;
>> +
> 		// c1 got moved out of p2 while we'd been taking locks;
> 		// unlock and fall back to slow case
>> +		inode_unlock(p2->d_inode);
>> +	}
>> +
>> +	mutex_lock(&c1->d_sb->s_vfs_rename_mutex);
> 	// nobody can move out of any directories on this fs
>> +	if (likely(c1->d_parent != p2))
>> +		return lock_two_directories(c1->d_parent, p2);
>> +
> 	// c1 got moved into p2 while we were taking locks;
> 	// we need p2 locked and ->s_vfs_rename_mutex unlocked,
> 	// for consistency with lock_rename().
>> +	inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
>> +	mutex_unlock(&c1->d_sb->s_vfs_rename_mutex);
>> +	return NULL;
>> +}
>> +EXPORT_SYMBOL(lock_rename_child);
>
