Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED43793D35
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 14:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240830AbjIFM4f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 08:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjIFM4f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:56:35 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A338A171C;
        Wed,  6 Sep 2023 05:56:26 -0700 (PDT)
Received: from fsav120.sakura.ne.jp (fsav120.sakura.ne.jp [27.133.134.247])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 386Cu4e3090843;
        Wed, 6 Sep 2023 21:56:04 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav120.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp);
 Wed, 06 Sep 2023 21:56:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 386Cu3xb090838
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 6 Sep 2023 21:56:04 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c4d0bbf2-c4a8-cb2e-e941-a68a15cfb042@I-love.SAKURA.ne.jp>
Date:   Wed, 6 Sep 2023 21:56:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] f2fs: fix deadlock in f2f2_add_dentry
Content-Language: en-US
To:     Lizhi Xu <lizhi.xu@windriver.com>,
        syzbot+a4976ce949df66b1ddf1@syzkaller.appspotmail.com
Cc:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000000f188605ffdd9cf8@google.com>
 <20230825053732.3098387-1-lizhi.xu@windriver.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20230825053732.3098387-1-lizhi.xu@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/08/25 14:37, Lizhi Xu wrote:
> @@ -736,12 +736,12 @@ int f2fs_add_regular_entry(struct inode *dir, const struct f2fs_filename *fname,
>  	f2fs_wait_on_page_writeback(dentry_page, DATA, true, true);
>  
>  	if (inode) {
> -		f2fs_down_write(&F2FS_I(inode)->i_sem);
>  		page = f2fs_init_inode_metadata(inode, dir, fname, NULL);
>  		if (IS_ERR(page)) {
>  			err = PTR_ERR(page);
>  			goto fail;
>  		}
> +		f2fs_down_write(&F2FS_I(inode)->i_sem);
>  	}

Above change does not match below.

fail:
	if (inode)
		f2fs_up_write(&F2FS_I(inode)->i_sem);

>  
>  	make_dentry_ptr_block(NULL, &d, dentry_blk);

