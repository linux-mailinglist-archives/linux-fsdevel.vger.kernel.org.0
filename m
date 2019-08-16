Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C54038FEA2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 11:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfHPJBS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 05:01:18 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38761 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfHPJBR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 05:01:17 -0400
Received: by mail-ed1-f66.google.com with SMTP id r12so4529939edo.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2019 02:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mSiAk67V3GMYLn1om5daOi37BkfEgDmswBLAwO4i6c0=;
        b=ILMkrwpiD37VtGx8RBWd7oS4d0RwmhQYqWpiHueDLUNW/jChv4LZT+kuX62iGbmC+H
         ctmgVtsLPwTmM0vZsN7OW/tBUb/LKo7Raf8JE0DBgj6c7kmFHtOruEsXF6HQmKxiUZuN
         2lV4TNH2yYFoyEe6e6Ra1rJxMjotoXoTP7KeMDUO3/nvw+YVArdSD4HYfJujSqW3Lt6L
         Xg33jCpNUED2RDn7Kco/xrTyIrqEB5FIJry7s8BwM3VWY9nmQNkCybvLeYhtgl62fTBu
         7AvCXAMRiKVplAIglZs+G8fbP0srI7NHki4wESljpCGRwzSZFl65+bPaDIRYDZcJ+Hmb
         XY5A==
X-Gm-Message-State: APjAAAV2zdICGDAwWfNWRgOwIMYK2OI4R82Zy/sDNoWbLDrCov/lav/h
        poRxo10DiEhdbYXO5o9paLO5ceU2DT0=
X-Google-Smtp-Source: APXvYqx2WDprqXWq6ptbb++ZslTqLZsP+y0qFQxjEFCmn/f2/tZE5oDTvzZh57XQeh6vZ+NAJNB63w==
X-Received: by 2002:aa7:d2cb:: with SMTP id k11mr9866284edr.12.1565946075200;
        Fri, 16 Aug 2019 02:01:15 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id sa25sm734297ejb.37.2019.08.16.02.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2019 02:01:14 -0700 (PDT)
Subject: Re: [PATCH v13] fs: Add VirtualBox guest shared folder (vboxsf)
 support
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
References: <20190815131253.237921-1-hdegoede@redhat.com>
 <20190815131253.237921-2-hdegoede@redhat.com>
 <20190816075654.GA15363@infradead.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <412a10a9-a681-4c7a-9175-e7509b3fea87@redhat.com>
Date:   Fri, 16 Aug 2019 11:01:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816075654.GA15363@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Thank you once more more for the review and also for
the quick turn-around time.

On 16-08-19 09:56, Christoph Hellwig wrote:
> A couple minor comments.  Otherwise we should be fine, things aren't
> going to get much better for such a messed up protocol design.
> 
>> +			return dir_emit(ctx, d_name, strlen(d_name),
>> +					fake_ino, d_type);
>> +		} else {
>> +			return dir_emit(ctx,
>> +					info->name.string.utf8,
>> +					info->name.length,
>> +					fake_ino, d_type);
>> +		}
>> +	}
> 
> Nitpick: no need for an else after a return.

Fixed for the next version.

>> +static int vboxsf_file_release(struct inode *inode, struct file *file)
>> +{
>> +	struct vboxsf_inode *sf_i = VBOXSF_I(inode);
>> +	struct vboxsf_handle *sf_handle = file->private_data;
>> +
>> +	filemap_write_and_wait(inode->i_mapping);
> 
> Normal Linux semantics don't include writing back data on close, so
> if you are doing this to follow other things like NFS CTO semantics
> it should have a comment explaining that.

Ok, I've added the following comment for the next version:

         /*
          * When a file is closed on our (the guest) side, we want any subsequent
          * accesses done on the host side to see all changes done from our side.
          */
         filemap_write_and_wait(inode->i_mapping);

>> +
>> +	mutex_lock(&sf_i->handle_list_mutex);
>> +	list_del(&sf_handle->head);
>> +	mutex_unlock(&sf_i->handle_list_mutex);
>> +
>> +	kref_put(&sf_handle->refcount, vboxsf_handle_release);
>> +	file->private_data = NULL;
> 
> There is no need to zero ->private_data on release, the file gets
> freed and never reused.

Fixed for the next version.

>> + * Ideally we would wrap generic_file_read_iter with a function which also
>> + * does this check, to reduce the chance of us missing writes happening on the
>> + * host side after open(). But the vboxsf stat call to the host only works on
>> + * filenames, so that would require caching the filename in our
>> + * file->private_data and there is no guarantee that filename will still
>> + * be valid at read_iter time. So this would be in no way bulletproof.
> 
> Well, you can usually generate a file name from file->f_path.dentry.
> The only odd case is opened by unliked files.  NFS has a special hack
> for those called sillyrename (you can grep for that). 

Right, so since the unlink or a normal rename could happen on the host side
and there is no notification of that, those will be 2 areas where a stat
call to verify will fail, which leaves us with 3 options:

1) Make stat calls before read() calls, if they fail purge the cache to be safe
2) Make stat calls before read(), on failure ignore the stat call
3) Treat read() calls like other page-cache reads such as sendfile or mmap
and only check if the cache is stale at open() time.

> How similar to normal posix semantics are expected from this fs?

Similar enough to have most apps work normally. Certainly we should make
all accesses from the guest side be consistent with each other / have
full posix semantics.

But mixing writes from both the host and guest side is something which the
user IMHO should simply be careful with doing. Until I fixed it about a year
ago there was a long standing bug upstream where users would edit web-pages
on the host and then serve them from Apache on the guest. Apache would use
sendfile, going through the pagecache and keep serving the old file.
This is where the stale cache check in vboxsf_inode_revalidate() comes from
I added that to fix this issue.

The out of tree version of vboxsf is in use for many years and they have
gotten away without even the staleness check at open time() all that
time. To be fair they did pass through read() calls directly to the host
without going through the page-cache but that causes consistency issues
for accesses from within the guest which are more important to get right
IMHO, as there we can actually get things right.

TL;DR: I believe that the current approach which is 3. from above is
good enough and I like that it is very KISS. We can always switch to
1. or 2. (or add 1. and 2. and make it configurable) later if this shows
to be necessary.

Can you please let me know if option 3. / the KISS method is ok with you,
or if you would prefer me to add code to do 1. or 2?

Once I have an answer on this I will post a new version.

>> +
>> +	mutex_lock(&sf_i->handle_list_mutex);
>> +	list_for_each_entry(h, &sf_i->handle_list, head) {
>> +		if (h->access_flags == SHFL_CF_ACCESS_WRITE ||
>> +		    h->access_flags == SHFL_CF_ACCESS_READWRITE) {
>> +			kref_get(&h->refcount);
> 
> Does this need a kref_get_unless_zero to deal with races during list
> removal?

List remove always happens with the handle_list_mutex held, so no
that is not necessary.

Regards,

Hans
