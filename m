Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B831C5366
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 12:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgEEKhd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 06:37:33 -0400
Received: from verein.lst.de ([213.95.11.211]:34571 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728401AbgEEKhd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 06:37:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 756B368C4E; Tue,  5 May 2020 12:37:29 +0200 (CEST)
Date:   Tue, 5 May 2020 12:37:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-ext4@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, tytso@mit.edu,
        adilger@dilger.ca, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 08/11] fs: move fiemap range validation into the file
 systems instances
Message-ID: <20200505103729.GB15815@lst.de>
References: <20200427181957.1606257-1-hch@lst.de> <20200427181957.1606257-9-hch@lst.de> <20200501224906.6B273AE04D@d06av26.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501224906.6B273AE04D@d06av26.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 02, 2020 at 04:19:05AM +0530, Ritesh Harjani wrote:
>> -int fiemap_check_flags(struct fiemap_extent_info *fieinfo, u32 fs_flags);
>> +fiemap_prep() helper.
>
> Let's add the fiemap_prep() function prototype here.
> So that below description would make more sense.

The annoying tendency to copy prototypes into docs just means they
get out of date.  Anyone who can't do a quick grep should not be
writing code.  I've added it back for consistency, but we really
should remove all of them in this file.

>> ioctl_fiemap(). The
>>   set of fiemap flags which the fs understands should be passed via fs_flags. If
>> -fiemap_check_flags finds invalid user flags, it will place the bad values in
>> +fiemap_prep finds invalid user flags, it will place the bad values in
>>   fieinfo->fi_flags and return -EBADR. If the file system gets -EBADR, from
>> -fiemap_check_flags(), it should immediately exit, returning that error back to
>> +fiemap_prep(), it should immediately exit, returning that error back to
>>   ioctl_fiemap().
>
> Also maybe we should also add more info about fiemap_prep() helper.
> Since it also checks for invalid len and invalid start range and hence
> could return -EINVAL or -EFBIG.

I've added it.  But this kind of documentation that just badly spells
out what is done is not very useful.  A quick look at the function
conveys the information much better.

>> --- a/fs/cifs/smb2ops.c
>> +++ b/fs/cifs/smb2ops.c
>> @@ -3408,8 +3408,10 @@ static int smb3_fiemap(struct cifs_tcon *tcon,
>>   	int i, num, rc, flags, last_blob;
>>   	u64 next;
>>   -	if (fiemap_check_flags(fei, FIEMAP_FLAG_SYNC))
>> -		return -EBADR;
>> +	rc = fiemap_prep(cfile->dentry->d_inode, fei, start, &len,
>> +			FIEMAP_FLAG_SYNC);
>
> How about d_inode(cfile->dentry) ?

Ok.

>> +	if (rc)
>> +		rc;
>
> missed "return rc" here?

Indeed.

>> + * @start:	Start of the mapped range
>> + * @len:	Length of the mapped range, can be truncated by this function.
>> + * @supported_flags:	Set of fiemap flags that the file system understands
>>    *
>>    * Called from file system ->fiemap callback. This will compute the
>>    * intersection of valid fiemap flags and those that the fs supports. That
>
> Let's also add more documentation about this new fiemap_prep() helper.
> Earlier comments above this function description only talks about
> incompat flags. We should add more info about check_ranges part as well 
> here.

Seriously, the details are in the f^$^$ing code.  No need to have an
easily out of sync version of the code in the comment.  I'll just
radically shorten this.
