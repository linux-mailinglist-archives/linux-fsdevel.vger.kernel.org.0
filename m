Return-Path: <linux-fsdevel+bounces-2258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AD07E4149
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 14:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 429D5B20D10
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 13:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A67330F84;
	Tue,  7 Nov 2023 13:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGdBi/DF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84718182C8
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 13:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40508C433C8;
	Tue,  7 Nov 2023 13:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699365342;
	bh=MezwdNposfNXG2orKfNEfaD6ELS73ydUqk05+JkokFc=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
	b=BGdBi/DFC+qLlPIJwKRW1zKfsKHtJt/sHqj019yxcoFZemUY11tWCVltoekoxrv1s
	 jPMtNaWWznziiOGpNBpCyWhwVPF93tz5COveJkuedJjWYWjuKEJq/Ur1QTo4ile0fF
	 2X7pB5mrhKsJxcbYlLyCRGZ8+CPOFjevhxBXyCAZAg9xQs0zMc0snrNHjzjt8w663y
	 ExTwZ06jymVrM92JDbWCsbM0eeTSMSCB1hD7sjSETFlSu1kA9P/ddUghfx0FLKeIT2
	 Csrw1lAul8ydceYG8m6yMpunyctpj4/jeaVrGDmwG8U9Er0CLJWBPSXm4WwCjgQxtF
	 fmZBwiD2YtZUQ==
Message-ID: <b458cd8f-8af0-5848-29dc-353d536ee77a@kernel.org>
Date: Tue, 7 Nov 2023 21:55:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20231011203412.GA85476@ZenIV>
 <CAHk-=wjSbompMCgMwR2-MB59QDB+OZ7Ohp878QoDc9o7z4pbNg@mail.gmail.com>
 <20231011215138.GX800259@ZenIV> <20231011230105.GA92231@ZenIV>
 <CAHfrynNbfPtAjY4Y7N0cyWyH35dyF_BcpfR58ASCCC7=-TfSFw@mail.gmail.com>
 <20231012050209.GY800259@ZenIV> <20231012103157.mmn6sv4e6hfrqkai@quack3>
 <20231012145758.yopnkhijksae5akp@quack3> <20231012191551.GZ800259@ZenIV>
 <20231017055040.GN800259@ZenIV> <20231026161653.cunh4ojohq6mw2ye@quack3>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
Subject: Re: [RFC] weirdness in f2fs_rename() with RENAME_WHITEOUT
In-Reply-To: <20231026161653.cunh4ojohq6mw2ye@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/10/27 0:16, Jan Kara wrote:
> Jaegeuk, Chao, any comment on this? It really looks like a filesystem
> corruption issue in f2fs when whiteouts are used...

Sorry for delay reply, I was busy handling product issues these days...

Let me check this ASAP.

Thanks,

> 
> 								Honza
> 
> On Tue 17-10-23 06:50:40, Al Viro wrote:
>> [f2fs folks Cc'd]
>>
>> 	There's something very odd in f2fs_rename();
>> this:
>>          f2fs_down_write(&F2FS_I(old_inode)->i_sem);
>>          if (!old_dir_entry || whiteout)
>>                  file_lost_pino(old_inode);
>>          else
>>                  /* adjust dir's i_pino to pass fsck check */
>>                  f2fs_i_pino_write(old_inode, new_dir->i_ino);
>>          f2fs_up_write(&F2FS_I(old_inode)->i_sem);
>> and this:
>>                  if (old_dir != new_dir && !whiteout)
>>                          f2fs_set_link(old_inode, old_dir_entry,
>>                                                  old_dir_page, new_dir);
>>                  else
>>                          f2fs_put_page(old_dir_page, 0);
>> The latter really stinks, especially considering
>> struct dentry *f2fs_get_parent(struct dentry *child)
>> {
>>          struct page *page;
>>          unsigned long ino = f2fs_inode_by_name(d_inode(child), &dotdot_name, &page);
>>
>>          if (!ino) {
>>                  if (IS_ERR(page))
>>                          return ERR_CAST(page);
>>                  return ERR_PTR(-ENOENT);
>>          }
>>          return d_obtain_alias(f2fs_iget(child->d_sb, ino));
>> }
>>
>> You want correct inumber in the ".." link.  And cross-directory
>> rename does move the source to new parent, even if you'd been asked
>> to leave a whiteout in the old place.
>>
>> Why is that stuff conditional on whiteout?  AFAICS, that went into the
>> tree in the same commit that added RENAME_WHITEOUT support on f2fs,
>> mentioning "For now, we just try to follow the way that xfs/ext4 use"
>> in commit message.  But ext4 does *NOT* do anything of that sort -
>> at the time of that commit the relevant piece had been
>>          if (old.dir_bh) {
>> 		retval = ext4_rename_dir_finish(handle, &old, new.dir->i_ino);
>> and old.dir_bh is set by
>>                  retval = ext4_rename_dir_prepare(handle, &old);
>> a few lines prior, which is not conditional upon the whiteout.
>>
>> What am I missing there?

