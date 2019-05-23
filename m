Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C594B27FA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 16:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbfEWO2j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 10:28:39 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40230 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730757AbfEWO2i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 10:28:38 -0400
Received: by mail-io1-f65.google.com with SMTP id s20so5002828ioj.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2019 07:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RpoaZHiLYMmGlhX0k0xc+98b7kVM8O0Nb+ulnrgtNJY=;
        b=eH5v3tpg2jWcAPb1BtxrbVrTwVUfKiSWlvBDKjPnMCLKVULShlUKgTwitBPVj8R67S
         bl1SbiSsoHmzObZJaBxdW4O3YF9bi/hDQVh4LM4xPKTAcWNU8KdkloCUphchsoElrid6
         6AE/lgpbQOcODzePbiuHNI5h5RQVYZ3DdiPNZ1P21NCTx0RWpesYRMzTQk9Tx9wVH82F
         3QjTfmq966opB3u1fxAMKVkxd+GjbHM+SN0LX9x6Dx0Gop9JfYNLNSq6TGOipNEymeNB
         dRNv03qtNpwfVHrkY4WBtB5KiozY7XbCo0INoRR2QE2B56FK+0X4wpaY3eTtXiJMWQV6
         F5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RpoaZHiLYMmGlhX0k0xc+98b7kVM8O0Nb+ulnrgtNJY=;
        b=VmLNyeUZVFh9IOQevl5UcNUfBatYIu/UvqjYC67zybfUtksMvWry5RMyRhp/xFRj97
         ans95BAv3Ed133hGccPKP/WWXZj6RzW9cKGaUWGna8TV6Kxxtm7pQjEZtACXHccDe5go
         PAILhFezcn8lDu1r6GTilfmk/gkArAmHloFCz/kv+q4UR2H3MRDDLY9Lfdj1xKoFO4OB
         gQ8V1nLiL+5Rzf9kn6i8f0iZsyTsRPcA5+Y6LOVCbdw1DUGpeLFUGfKSaHyB2mdylQzQ
         a3yM71K3r9GGui3HEmnEAMczH2R85dw9ObWpFL/zIL8/xPFTfviurM/rMZQ9uSSTLx0z
         2uBA==
X-Gm-Message-State: APjAAAV2M6IzqDztgHBRvzS8QsJdy2W7Qh0QWSMka1wyF7jDF4zAhKCL
        4YNE3HcsePZLEzO5nDjMofhtxg==
X-Google-Smtp-Source: APXvYqx8LKzOGpiWsL6dTrqW1tpjf/a6M4DwvCuMOWOiEPh8pOdaLx/XEPvYVwOl6hL0YBJIUNsKYw==
X-Received: by 2002:a6b:ca47:: with SMTP id a68mr20174292iog.227.1558621717396;
        Thu, 23 May 2019 07:28:37 -0700 (PDT)
Received: from brauner.io ([172.56.12.187])
        by smtp.gmail.com with ESMTPSA id w186sm4196873ita.3.2019.05.23.07.28.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 23 May 2019 07:28:36 -0700 (PDT)
Date:   Thu, 23 May 2019 16:28:28 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        torvalds@linux-foundation.org, fweimer@redhat.com,
        jannh@google.com, tglx@linutronix.de, arnd@arndb.de,
        shuah@kernel.org, dhowells@redhat.com, tkjos@android.com,
        ldv@altlinux.org, miklos@szeredi.hu, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v1 1/2] open: add close_range()
Message-ID: <20190523142826.omb7vgygudifmveq@brauner.io>
References: <20190522155259.11174-1-christian@brauner.io>
 <20190522165737.GC4915@redhat.com>
 <20190523115118.pmscbd6kaqy37dym@brauner.io>
 <20190523141447.34s3kc3fuwmoeq7n@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190523141447.34s3kc3fuwmoeq7n@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 04:14:47PM +0200, Christian Brauner wrote:
> On Thu, May 23, 2019 at 01:51:18PM +0200, Christian Brauner wrote:
> > On Wed, May 22, 2019 at 06:57:37PM +0200, Oleg Nesterov wrote:
> > > On 05/22, Christian Brauner wrote:
> > > >
> > > > +static struct file *pick_file(struct files_struct *files, unsigned fd)
> > > >  {
> > > > -	struct file *file;
> > > > +	struct file *file = NULL;
> > > >  	struct fdtable *fdt;
> > > >  
> > > >  	spin_lock(&files->file_lock);
> > > > @@ -632,15 +629,65 @@ int __close_fd(struct files_struct *files, unsigned fd)
> > > >  		goto out_unlock;
> > > >  	rcu_assign_pointer(fdt->fd[fd], NULL);
> > > >  	__put_unused_fd(files, fd);
> > > > -	spin_unlock(&files->file_lock);
> > > > -	return filp_close(file, files);
> > > >  
> > > >  out_unlock:
> > > >  	spin_unlock(&files->file_lock);
> > > > -	return -EBADF;
> > > > +	return file;
> > > 
> > > ...
> > > 
> > > > +int __close_range(struct files_struct *files, unsigned fd, unsigned max_fd)
> > > > +{
> > > > +	unsigned int cur_max;
> > > > +
> > > > +	if (fd > max_fd)
> > > > +		return -EINVAL;
> > > > +
> > > > +	rcu_read_lock();
> > > > +	cur_max = files_fdtable(files)->max_fds;
> > > > +	rcu_read_unlock();
> > > > +
> > > > +	/* cap to last valid index into fdtable */
> > > > +	if (max_fd >= cur_max)
> > > > +		max_fd = cur_max - 1;
> > > > +
> > > > +	while (fd <= max_fd) {
> > > > +		struct file *file;
> > > > +
> > > > +		file = pick_file(files, fd++);
> > > 
> > > Well, how about something like
> > > 
> > > 	static unsigned int find_next_opened_fd(struct fdtable *fdt, unsigned start)
> > > 	{
> > > 		unsigned int maxfd = fdt->max_fds;
> > > 		unsigned int maxbit = maxfd / BITS_PER_LONG;
> > > 		unsigned int bitbit = start / BITS_PER_LONG;
> > > 
> > > 		bitbit = find_next_bit(fdt->full_fds_bits, maxbit, bitbit) * BITS_PER_LONG;
> > > 		if (bitbit > maxfd)
> > > 			return maxfd;
> > > 		if (bitbit > start)
> > > 			start = bitbit;
> > > 		return find_next_bit(fdt->open_fds, maxfd, start);
> > > 	}
> > 
> > > 
> > > 	unsigned close_next_fd(struct files_struct *files, unsigned start, unsigned maxfd)
> > > 	{
> > > 		unsigned fd;
> > > 		struct file *file;
> > > 		struct fdtable *fdt;
> > > 	
> > > 		spin_lock(&files->file_lock);
> > > 		fdt = files_fdtable(files);
> > > 		fd = find_next_opened_fd(fdt, start);
> > > 		if (fd >= fdt->max_fds || fd > maxfd) {
> > > 			fd = -1;
> > > 			goto out;
> > > 		}
> > > 
> > > 		file = fdt->fd[fd];
> > > 		rcu_assign_pointer(fdt->fd[fd], NULL);
> > > 		__put_unused_fd(files, fd);
> > > 	out:
> > > 		spin_unlock(&files->file_lock);
> > > 
> > > 		if (fd == -1u)
> > > 			return fd;
> > > 
> > > 		filp_close(file, files);
> > > 		return fd + 1;
> > > 	}
> > 
> > Thanks, Oleg!
> > 
> > I kept it dumb and was about to reply that your solution introduces more
> > code when it seemed we wanted to keep this very simple for now.
> > But then I saw that find_next_opened_fd() already exists as
> > find_next_fd(). So it's actually not bad compared to what I sent in v1.
> > So - with some small tweaks (need to test it and all now) - how do we
> > feel about?:
> 
> That's obviously not correct atm but I'll send out a tweaked version in
> a bit.

So given that we would really need another find_next_open_fd() I think
sticking to the simple cond_resched() version I sent before is better
for now until we see real-world performance issues.
I was however missing a test for close_range(fd, fd, 0) anyway so I'll
need to send a v2 with this test added.

Christian
