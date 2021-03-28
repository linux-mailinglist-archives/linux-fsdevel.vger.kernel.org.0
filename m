Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1451A34BD0C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Mar 2021 17:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhC1PtX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Mar 2021 11:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhC1PtK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Mar 2021 11:49:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DADC061756;
        Sun, 28 Mar 2021 08:49:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 9D0AA1F4629A
Subject: Re: [PATCH 1/3] fs/dcache: Add d_clear_dir_neg_dentries()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        krisman@collabora.com, kernel@collabora.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Daniel Rosenberg <drosen@google.com>,
        Chao Yu <yuchao0@huawei.com>
References: <20210328144356.12866-1-andrealmeid@collabora.com>
 <20210328144356.12866-2-andrealmeid@collabora.com>
 <20210328150715.GA33249@casper.infradead.org>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <74ca03a0-1975-8b9f-f9af-c15946580904@collabora.com>
Date:   Sun, 28 Mar 2021 12:49:01 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210328150715.GA33249@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Às 12:07 de 28/03/21, Matthew Wilcox escreveu:
> On Sun, Mar 28, 2021 at 11:43:54AM -0300, André Almeida wrote:
>> +/**
>> + * d_clear_dir_neg_dentries - Remove negative dentries in an inode
>> + * @dir: Directory to clear negative dentries
>> + *
>> + * For directories with negative dentries that are becoming case-insensitive
>> + * dirs, we need to remove all those negative dentries, otherwise they will
>> + * become dangling dentries. During the creation of a new file, if a d_hash
>> + * collision happens and the names match in a case-insensitive, the name of
>> + * the file will be the name defined at the negative dentry, that can be
>> + * different from the specified by the user. To prevent this from happening, we
>> + * need to remove all dentries in a directory. Given that the directory must be
>> + * empty before we call this function we are sure that all dentries there will
>> + * be negative.
>> + */
> 
> This is quite the landmine of a function.  It _assumes_ that the directory
> is empty, and clears all dentries in it.
> 
>> +void d_clear_dir_neg_dentries(struct inode *dir)
>> +{
>> +	struct dentry *alias, *dentry;
>> +
>> +	hlist_for_each_entry(alias, &dir->i_dentry, d_u.d_alias) {
>> +		list_for_each_entry(dentry, &alias->d_subdirs, d_child) {
>> +			d_drop(dentry);
>> +			dput(dentry);
>> +		}
> 
> I would be happier if it included a check for negativity.  d_is_negative()
> or maybe this newfangled d_really_is_negative() (i haven't stayed up
> to speed on the precise difference between the two)
> 

Makes sense. And given that this only makes sense if the directory is 
empty, if it founds a non-negative dentry, it should return some error 
right?

>> +	}
>> +}
>> +EXPORT_SYMBOL(d_clear_dir_neg_dentries);
> 
> I'd rather see this _GPL for such an internal thing.
> 
