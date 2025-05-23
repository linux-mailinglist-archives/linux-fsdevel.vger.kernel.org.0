Return-Path: <linux-fsdevel+bounces-49701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897B1AC18FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 02:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1BA04A5612
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 00:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C661C84DC;
	Fri, 23 May 2025 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hk5UMMcT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8561F30BB;
	Fri, 23 May 2025 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747960209; cv=none; b=uevJdUyYcNz1ijY3hKu1YglEdTfui2lMHWNCYYqOM2mvw399GgIpfDTiFa+ZhKVjcepTLAzxd37aJ0NPYhVk4bQ2pN7GQDAR4T8eT2opuq6xdcLovDnRtHetwaXnWrHvHdQ4boTcsmEpdwNYtq/uVgskKjKu/xqUysLjOfsdDeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747960209; c=relaxed/simple;
	bh=Wl5YfiDuVTh4ATPHm/VPfxVkWv4VXMTmqAwd1VupLRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r95zDFMZMQFuVZKSsl7Es4OVxSnlcStm6NBGBzkY98DUdLCljvB4QNkCpKMToJrbm2zIaFYSK8zUwOXL58hSI/ovGAlC25xnCmqcfylWGoBon26VUq8LBBpMnLAoKkAKWiPQEF9paF9bTUpOVfaqZbn88sYEv5/fxZFYPENangk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hk5UMMcT; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2cc57330163so4495697fac.2;
        Thu, 22 May 2025 17:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747960206; x=1748565006; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l3DeqVyXhMjUkCDgLsB9zplddhMp4wWfdmMvRjbrEdM=;
        b=Hk5UMMcT3QcuLWSD68waWnej7XsddP2NPC3XzhhXXEbsXeDD1TP6dbNKcBie+GdxUA
         LeVVMNrvnWBf9sLy0fwWZ+XasEaCMaaqEmjIpvkmVMmodbNrbQ6U0k4ywZ6Pm0Inn9hQ
         qZNBQwoBiDLd6S8NR9raZIJS/gJBpjt/SX6bOD9skVTlsC6UY/QU19niUfp50wXyXFbg
         gJVLABwqYHeC0pUkB3T1jTTwXFPZyFrQDw3iE5wcKnn0WEfh0t4QDCIAPTdyXOsHSxoy
         BskkiL4OghMp6ug272301xtJxpTPqV1ROJYf8t3tJLE1JTb2zAc3X+jI/o/9NeJCLvPJ
         li/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747960206; x=1748565006;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l3DeqVyXhMjUkCDgLsB9zplddhMp4wWfdmMvRjbrEdM=;
        b=BhC/ohJuyanQpZGVLG0MUN5AgLH+VcyN7BFg3vMOmvj8VVUGtIpardCfnCAXR6OIs8
         8hIeIG1xPAkyL+/OQqVyF59Lr2+yYguqm/Enr34/eKcoJy/t9wCQbRaggdmxGJlfHLo3
         qJND3HVttliohAaw2Sdu6jvhZmj49vRGrZJqNaQCBMk+vmdYxmroaHL/6hqhAkZhSZlS
         Ygn95HfCrZeRSLl6Lehi4ImmXvLndD4KJ7G0E+zK3JMZ3zrwvjttdr/ba/21BSlDQO4h
         hCWz0N6TY22ib5UHobD3HGXJO6tUmZo6PDkj0nGEUhKnUg7BGvXfe0jsQCFy63IVZUMl
         S+Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUNZmefnP2f6AvnHSTEXQ01YI+V7Cyl9BFHidqjCkR/mCp3hSI1yGXpb071vMuYTaa6umuD2YHtyeo=@vger.kernel.org, AJvYcCW3fNqULggXlUqk6nh+O7lFaqVWFaPDs7cjIideq0bhfzRNf6tyinbWLd8d9trqD8c6Dr0JXsJ1uYZ8zzJq@vger.kernel.org, AJvYcCWTFmInN6y8RM0pGUDkEq1U56IXbtV72rAP2ev2nmaY4S3+kBBX1awsDsif9Y/0bZz6y+AEZIzcl8ig@vger.kernel.org, AJvYcCXdtv0fCMDCLRHLGXMnFZvjHb1nU5uuFuEJNX3jYDmSA0tVMvMifcGo90yKW94SnITlN7AmKOT8d4FAwhiRGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcqxDAmOwjIlQCkR8BoNhxw54QnP4/p6aa2W6gnR5RCDcwYmao
	4hbbV8J618D6+wPdJayvnWPbgRNW5jEh6Y++77g+/miEJrHpV+fGQmfD
X-Gm-Gg: ASbGncsL1GNrJZFi0ukl01ghY430l6x00nDW/P9uPMoHcr15yEOlQDobYlHLrF7tRbf
	XW5W+AkV0/OyioTsy+QCWxaaN74lqZ0mdY/EORk/+tFAX7Hwoh34rOd/AnLypDqGkugMUU6hnOP
	nYrksEvVgc389GmqkI19Xyv38H8Ig9u26hCWkv2VTwGLYlzm6SrfKMqtnOTGUMUp6ewhtk7NY5V
	/wZ2GaNn+zx3BGHlQ3FgfIo1mvBxrnj2W97bMp4oHs0g+coK3qp9IYfILaOLImnRrFb+Gm995do
	rc6Xrq46XZoG7oCKYGkr9BW98ClNGxtrSCtRHM6rKNbQLUi8JBfoANfBLZRySlrEGg==
X-Google-Smtp-Source: AGHT+IGzkPKh4ltsHgJ3DC9EjVHlO8KxAU5N7rqWDv9531QCEztz3JUTMJs31ibfrfp+x7mffoOdEw==
X-Received: by 2002:a05:6871:aa14:b0:29d:c85f:bc8c with SMTP id 586e51a60fabf-2e3c1f50b50mr17123684fac.36.1747960206336;
        Thu, 22 May 2025 17:30:06 -0700 (PDT)
Received: from groves.net ([2603:8080:1500:3d89:5d18:dfdf:ed52:cd5d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2e3c0a9e02dsm3339566fac.35.2025.05.22.17.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 17:30:04 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Thu, 22 May 2025 19:30:02 -0500
From: John Groves <John@groves.net>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, 
	Dan Williams <dan.j.williams@intel.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Bernd Schubert <bschubert@ddn.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Luis Henriques <luis@igalia.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Petr Vorel <pvorel@suse.cz>, Brian Foster <bfoster@redhat.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC PATCH 12/19] famfs_fuse: Plumb the GET_FMAP message/response
Message-ID: <dgt4gpgpc4f3455rxdhztvnbmewdo3yw44b7mbs4tj2bt2x56n@dr5txuwm2c37>
References: <20250421013346.32530-1-john@groves.net>
 <20250421013346.32530-13-john@groves.net>
 <CAJnrk1ZRSoMN+jan5D9d3UYWnTVxc_5KVaBtP7JV2b+0skrBfg@mail.gmail.com>
 <xhekfz652u3dla26aj4ge45zr4tk76b2jgkcb22jfo46gvf6ry@zze73cprkx6g>
 <CAOQ4uxj73Z8Hee1U7LxABYKoHbowA4ARBFDv434yDq+qn5iMZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj73Z8Hee1U7LxABYKoHbowA4ARBFDv434yDq+qn5iMZw@mail.gmail.com>

On 25/05/22 05:45PM, Amir Goldstein wrote:
> On Mon, May 12, 2025 at 6:28 PM John Groves <John@groves.net> wrote:
> >
> > On 25/05/01 10:48PM, Joanne Koong wrote:
> > > On Sun, Apr 20, 2025 at 6:34 PM John Groves <John@groves.net> wrote:
> > > >
> > > > Upon completion of a LOOKUP, if we're in famfs-mode we do a GET_FMAP to
> > > > retrieve and cache up the file-to-dax map in the kernel. If this
> > > > succeeds, read/write/mmap are resolved direct-to-dax with no upcalls.
> > > >
> > > > Signed-off-by: John Groves <john@groves.net>
> > > > ---
> ...
> > > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > > index 7f4b73e739cb..848c8818e6f7 100644
> > > > --- a/fs/fuse/inode.c
> > > > +++ b/fs/fuse/inode.c
> > > > @@ -117,6 +117,9 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
> > > >         if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> > > >                 fuse_inode_backing_set(fi, NULL);
> > > >
> > > > +       if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
> > > > +               famfs_meta_set(fi, NULL);
> > >
> > > "fi->famfs_meta = NULL;" looks simpler here
> >
> > I toootally agree here, but I was following the passthrough pattern
> > just above.  @miklos or @Amir, got a preference here?
> >
> 
> It's not about preference, this fails build.
> Even though compiler (or pre-processor whatever) should be able to skip
> "fi->famfs_meta = NULL;" if CONFIG_FUSE_FAMFS_DAX is not defined
> IIRC it does not. Feel free to try. Maybe I do not remember correctly.
> 
> Thanks,
> Amir.

Thanks Amir. Will fiddle with this when cleaning up V2.

John


