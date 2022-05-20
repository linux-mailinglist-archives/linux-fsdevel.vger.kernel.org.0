Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0B152E985
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 11:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347939AbiETJ62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 05:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347728AbiETJ60 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 05:58:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47840EC3FD;
        Fri, 20 May 2022 02:58:25 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F001B1F88B;
        Fri, 20 May 2022 09:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653040703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=64ihC9Z8An8BVNW7TtS5ZeiD3v6obwU4Wb5TbN/d6lE=;
        b=rtE5ey666MicJjXHbgWRKj4LKRbVjjbtZKGOlcEy0wYWsmtAxl0gOH3JIchkIUpk5/QrEx
        S2eehmOuYALLl7ipS8ZcojV8wS61nbxkTA8SHF+8lGFopefr0S+lketbS5TnIW9F35kJeK
        /jqQZ+v9kFHpDzNfHKmUMEFsPLGculw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653040703;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=64ihC9Z8An8BVNW7TtS5ZeiD3v6obwU4Wb5TbN/d6lE=;
        b=4WIMZ8b0BHB7yygq7FdP0yMfnRLqf4/mr1Eup2XUb9bb3irniVoZkLmTCJWqKJ2Ji9V8sO
        A4BhfRvi3GHbVMCg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C94CD2C141;
        Fri, 20 May 2022 09:58:23 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 26F32A0634; Fri, 20 May 2022 11:50:28 +0200 (CEST)
Date:   Fri, 20 May 2022 11:50:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tadeusz Struk <tadeusz.struk@linaro.org>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: kernel BUG in ext4_writepages
Message-ID: <20220520095028.rq4ef2o5nwetzog3@quack3>
References: <49ac1697-5235-ca2e-2738-f0399c26d718@linaro.org>
 <20220519122353.eqpnxiaybvobfszb@quack3.lan>
 <e9ccb919-1616-f94f-c465-7024011ad8e5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9ccb919-1616-f94f-c465-7024011ad8e5@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 19-05-22 16:14:17, Tadeusz Struk wrote:
> On 5/19/22 05:23, Jan Kara wrote:
> > Hi!
> > 
> > On Tue 10-05-22 15:28:38, Tadeusz Struk wrote:
> > > Syzbot found another BUG in ext4_writepages [1].
> > > This time it complains about inode with inline data.
> > > C reproducer can be found here [2]
> > > I was able to trigger it on 5.18.0-rc6
> > > 
> > > [1] https://syzkaller.appspot.com/bug?id=a1e89d09bbbcbd5c4cb45db230ee28c822953984
> > > [2] https://syzkaller.appspot.com/text?tag=ReproC&x=129da6caf00000
> > 
> > Thanks for report. This should be fixed by:
> > 
> > https://lore.kernel.org/all/20220516012752.17241-1-yebin10@huawei.com/
> 
> 
> In case of the syzbot bug there is something messed up with PAGE DIRTY flags
> and the way syzbot sets up the write. This is what triggers the crash:

Can you tell me where exactly we hit the bug? I've now noticed that this is
on 5.10 kernel and on vanilla 5.10 there's no BUG_ON on line 2753.

> $ ftrace -f ./repro
> ...
> [pid  2395] open("./bus", O_RDWR|O_CREAT|O_SYNC|O_NOATIME, 000 <unfinished ...>
> [pid  2395] <... open resumed> )        = 6
> ...
> [pid  2395] write(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", 22 <unfinished ...>
> ...
> [pid  2395] <... write resumed> )       = 22
> 
> One way I could fix it was to clear the PAGECACHE_TAG_DIRTY on the mapping in
> ext4_try_to_write_inline_data() after the page has been updated:
> 
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 9c076262770d..e4bbb53fa26f 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -715,6 +715,7 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
>  			put_page(page);
>  			goto out_up_read;
>  		}
> +		__xa_clear_mark(&mapping->i_pages, 0, PAGECACHE_TAG_DIRTY);
>  	}
>  	ret = 1;
> 
> Please let me know it if makes sense any I will send a proper patch.

No, this looks really wrong... We need to better understand what's going
on.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
