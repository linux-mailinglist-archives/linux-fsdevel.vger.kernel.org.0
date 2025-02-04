Return-Path: <linux-fsdevel+bounces-40785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF24A277E0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 18:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9217A18815BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 17:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8E421638F;
	Tue,  4 Feb 2025 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vz4kf2WO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9128B175A5
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738688754; cv=none; b=ayCnHxUhYpWktDRhOPdf/cRkaQz+sH+m1GEeaF2JAlAvx4Q9Q5UQVjZjjMSy1aCjxWwoMuPjkjT//XSBUD9Pqjf0YZskF9TJiGYmPNSD8Sm8sKMn7EwXki4CeNY+AvY6DVfXnsBf9x9XXudXj/983L6cA6o1riQ2HdgU70heruM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738688754; c=relaxed/simple;
	bh=GomrFe8MVzI1cwTPRs+Jfqa4MN4FHL1GVERX6M/L7T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWv0BZkx/CgeMhb1Ho81tOJ/dGe9I3JnVubZf43zTybFwnEo45OohYvy3rKnkUnNJrROoNM3TciPv2Wfamh9RsI2pmhAvY0N29MLF5/Xt34/yCoWCNRg+JWnEt1g78xeq8OuQ9rWIYuC8ny3oneaqJi3QV4D74ihDKOoyJFc620=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vz4kf2WO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738688751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x9F/V4CpkAOq/x1xOq3wHGfKd1dY+6v+k3+bp4QHg1U=;
	b=Vz4kf2WOSsHuiESMPB9gECDXy29FOOjViz/MqfvYzansv3CRPrytyf0OYiug6zt8tgpw+/
	BXXY87USbYU5PAY7gtWu2+jTaqp8yIHqYyrprSfRAylHUii0z8elucTiWMMYg9VOFPGQ8D
	M1GKGfBEQs+wJMYq2IWvtToipABSvZE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-2nr1dvbPORysZkN89MS--w-1; Tue, 04 Feb 2025 12:05:50 -0500
X-MC-Unique: 2nr1dvbPORysZkN89MS--w-1
X-Mimecast-MFC-AGG-ID: 2nr1dvbPORysZkN89MS--w
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2f9dc7916adso101027a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 09:05:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738688749; x=1739293549;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9F/V4CpkAOq/x1xOq3wHGfKd1dY+6v+k3+bp4QHg1U=;
        b=tG1gmZuL1CwTfxSNRyZ+DqZ0uDdxRbjJLMSQKPVofdCpfsF0mAEP4McdzZ1e5w4X8q
         1WazKpW2suC0vCIjoZIVlv/7GkvuKZcbMuIb4BEi/P6BGEMc9u3jALhOEU6UurjJ3DYA
         Ds7HTo+cq04BnJBHSV2sK5YQKvtZhHEu1I/sTMlFVhnf6zOSpfyyXcD2HREid018AmJJ
         YDSl3TzOJ4/fFnp4qxrcIXtzol7aNhj9F3PMVrD5C/Eudhpw9B+1Tpk/Mm/An+VNe37n
         jIiDojdKd7MxVTMMHWEvsoR5k8ij2SVUNDazAWNqltmY4Sy2iD5fJLUXZ0ejDGdXWHxx
         TqLA==
X-Forwarded-Encrypted: i=1; AJvYcCUM9rnp8dYx3jDbLDvMewkXAZBE73lH58gJGUZsH9UK5eufl3c0Y3DeY6opLm3aeCoRnCxYGqZJLxvN7gZ9@vger.kernel.org
X-Gm-Message-State: AOJu0YzRTkQn3pAO+1GlhPjgL3fqEmnoxlcbxbDwiutlqfpwFKj43q/t
	9umR5SGOeAink2UmNcPK1b+ohBcSuY5YW/M7cLusWXyslZ5S1sfIr0DSBd+Qv5bK5rL0Emhr3e5
	9xdYY3f88danQTHiT71XWEWdbRCvGhFpFRc7QGwtx9E2/DwL5dkFY4QN9F4gd6rk=
X-Gm-Gg: ASbGncumgF/OziQkPFOMCy6374/1knHAJknRXwhNpNRqxOyKwHhNm3DgAxYGynCkgiy
	51JWSmYZfFdijk4DdDkiFhF7h7eqvQg7UkALlr1EldfN34vtWwA/rW6fYMQJja10K/13FuT+tnk
	ReRHOMvmXA8A+cP0Ai3cLMb9njC6YorqtKRpU6G3lggvOHqCUQeKJXeo7tAFEeGZYktaYQqh3zs
	XDTfqxFD9PGllHMTs9dg/f0MVzcJQH8tHPLtJNGmDHS4mgVIK5JJ9j6OTZ+aM3N7Sh5ti+YJXg0
	bMjM7uP7CtBUkHyshs8ASqxFUB+kRoPSzZaFwV6XaZ6H2w==
X-Received: by 2002:a05:6a00:3927:b0:729:c7b:9385 with SMTP id d2e1a72fcca58-72fd0be5439mr38631691b3a.6.1738688747607;
        Tue, 04 Feb 2025 09:05:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtdoDctNPDj0AJ3zkj5BixyBnv5pcR/srhiGRMsDHr85XH4Ey26E6V0GalFIbmNo8a6xxKEg==
X-Received: by 2002:a05:6a00:3927:b0:729:c7b:9385 with SMTP id d2e1a72fcca58-72fd0be5439mr38631641b3a.6.1738688747097;
        Tue, 04 Feb 2025 09:05:47 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe631be8fsm10739369b3a.24.2025.02.04.09.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 09:05:46 -0800 (PST)
Date: Wed, 5 Feb 2025 01:05:41 +0800
From: Zorro Lang <zlang@redhat.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	bfoster@redhat.com, djwong@kernel.org, nirjhar@linux.ibm.com,
	kernel-team@meta.com
Subject: Re: [PATCH v5 1/2] fsx: support reads/writes from buffers backed by
 hugepages
Message-ID: <20250204170541.hmk6guovolh5ohbx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250121215641.1764359-1-joannelkoong@gmail.com>
 <20250121215641.1764359-2-joannelkoong@gmail.com>
 <20250202142518.r3xvf7mvfo2nhb7t@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAJnrk1YwBJQnFwYBcO50Xy2dA6df_SqQsHdpLux4wa-Yw5rXdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1YwBJQnFwYBcO50Xy2dA6df_SqQsHdpLux4wa-Yw5rXdg@mail.gmail.com>

On Mon, Feb 03, 2025 at 10:04:04AM -0800, Joanne Koong wrote:
> On Sun, Feb 2, 2025 at 6:25 AM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Tue, Jan 21, 2025 at 01:56:40PM -0800, Joanne Koong wrote:
> > > Add support for reads/writes from buffers backed by hugepages.
> > > This can be enabled through the '-h' flag. This flag should only be used
> > > on systems where THP capabilities are enabled.
> > >
> > > This is motivated by a recent bug that was due to faulty handling of
> > > userspace buffers backed by hugepages. This patch is a mitigation
> > > against problems like this in the future.
> > >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > Reviewed-by: Brian Foster <bfoster@redhat.com>
> > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > ---
> >
> > Those two test cases fail on old system which doesn't support
> > MADV_COLLAPSE:
> >
> >    fsx -N 10000 -l 500000 -h
> >   -fsx -N 10000 -o 8192 -l 500000 -h
> >   -fsx -N 10000 -o 128000 -l 500000 -h
> >   +MADV_COLLAPSE not supported. Can't support -h
> >
> > and
> >
> >    fsx -N 10000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
> >   -fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
> >   -fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
> >   +mapped writes DISABLED
> >   +MADV_COLLAPSE not supported. Can't support -h
> >
> > I'm wondering ...
> >
> > >  ltp/fsx.c | 166 +++++++++++++++++++++++++++++++++++++++++++++++++-----
> > >  1 file changed, 153 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > index 41933354..3be383c6 100644
> > > --- a/ltp/fsx.c
> > > +++ b/ltp/fsx.c
> > > @@ -190,6 +190,16 @@ int      o_direct;                       /* -Z */
> > >  int  aio = 0;
> > >  int  uring = 0;
> > >  int  mark_nr = 0;
> > > +int  hugepages = 0;                  /* -h flag */
> > > +
> > > +/* Stores info needed to periodically collapse hugepages */
> > > +struct hugepages_collapse_info {
> > > +     void *orig_good_buf;
> > > +     long good_buf_size;
> > > +     void *orig_temp_buf;
> > > +     long temp_buf_size;
> > > +};
> > > +struct hugepages_collapse_info hugepages_info;
> > >
> > >  int page_size;
> > >  int page_mask;
> > > @@ -2471,7 +2481,7 @@ void
> > >  usage(void)
> > >  {
> > >       fprintf(stdout, "usage: %s",
> > > -             "fsx [-dfknqxyzBEFHIJKLORWXZ0]\n\
> > > +             "fsx [-dfhknqxyzBEFHIJKLORWXZ0]\n\
> > >          [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid]\n\
> > >          [-l flen] [-m start:end] [-o oplen] [-p progressinterval]\n\
> > >          [-r readbdy] [-s style] [-t truncbdy] [-w writebdy]\n\
> > > @@ -2483,8 +2493,11 @@ usage(void)
> > >       -d: debug output for all operations\n\
> > >       -e: pollute post-eof on size changes (default 0)\n\
> > >       -f: flush and invalidate cache after I/O\n\
> > > -     -g X: write character X instead of random generated data\n\
> > > -     -i logdev: do integrity testing, logdev is the dm log writes device\n\
> > > +     -g X: write character X instead of random generated data\n"
> > > +#ifdef MADV_COLLAPSE
> > > +"    -h hugepages: use buffers backed by hugepages for reads/writes\n"
> > > +#endif
> > > +"    -i logdev: do integrity testing, logdev is the dm log writes device\n\
> > >       -j logid: prefix debug log messsages with this id\n\
> > >       -k: do not truncate existing file and use its size as upper bound on file size\n\
> > >       -l flen: the upper bound on file size (default 262144)\n\
> > > @@ -2833,11 +2846,41 @@ __test_fallocate(int mode, const char *mode_str)
> > >  #endif
> > >  }
> > >
> > > +/*
> > > + * Reclaim may break up hugepages, so do a best-effort collapse every once in
> > > + * a while.
> > > + */
> > > +static void
> > > +collapse_hugepages(void)
> > > +{
> > > +#ifdef MADV_COLLAPSE
> > > +     int ret;
> > > +
> > > +     /* re-collapse every 16k fsxops after we start */
> > > +     if (!numops || (numops & ((1U << 14) - 1)))
> > > +             return;
> > > +
> > > +     ret = madvise(hugepages_info.orig_good_buf,
> > > +                   hugepages_info.good_buf_size, MADV_COLLAPSE);
> > > +     if (ret)
> > > +             prt("collapsing hugepages for good_buf failed (numops=%llu): %s\n",
> > > +                  numops, strerror(errno));
> > > +     ret = madvise(hugepages_info.orig_temp_buf,
> > > +                   hugepages_info.temp_buf_size, MADV_COLLAPSE);
> > > +     if (ret)
> > > +             prt("collapsing hugepages for temp_buf failed (numops=%llu): %s\n",
> > > +                  numops, strerror(errno));
> > > +#endif
> > > +}
> > > +
> > >  bool
> > >  keep_running(void)
> > >  {
> > >       int ret;
> > >
> > > +     if (hugepages)
> > > +             collapse_hugepages();
> > > +
> > >       if (deadline.tv_nsec) {
> > >               struct timespec now;
> > >
> > > @@ -2856,6 +2899,103 @@ keep_running(void)
> > >       return numops-- != 0;
> > >  }
> > >
> > > +static long
> > > +get_hugepage_size(void)
> > > +{
> > > +     const char str[] = "Hugepagesize:";
> > > +     size_t str_len =  sizeof(str) - 1;
> > > +     unsigned int hugepage_size = 0;
> > > +     char buffer[64];
> > > +     FILE *file;
> > > +
> > > +     file = fopen("/proc/meminfo", "r");
> > > +     if (!file) {
> > > +             prterr("get_hugepage_size: fopen /proc/meminfo");
> > > +             return -1;
> > > +     }
> > > +     while (fgets(buffer, sizeof(buffer), file)) {
> > > +             if (strncmp(buffer, str, str_len) == 0) {
> > > +                     sscanf(buffer + str_len, "%u", &hugepage_size);
> > > +                     break;
> > > +             }
> > > +     }
> > > +     fclose(file);
> > > +     if (!hugepage_size) {
> > > +             prterr("get_hugepage_size: failed to find "
> > > +                     "hugepage size in /proc/meminfo\n");
> > > +             return -1;
> > > +     }
> > > +
> > > +     /* convert from KiB to bytes */
> > > +     return hugepage_size << 10;
> > > +}
> > > +
> > > +static void *
> > > +init_hugepages_buf(unsigned len, int hugepage_size, int alignment, long *buf_size)
> > > +{
> > > +     void *buf = NULL;
> > > +#ifdef MADV_COLLAPSE
> > > +     int ret;
> > > +     long size = roundup(len, hugepage_size) + alignment;
> > > +
> > > +     ret = posix_memalign(&buf, hugepage_size, size);
> > > +     if (ret) {
> > > +             prterr("posix_memalign for buf");
> > > +             return NULL;
> > > +     }
> > > +     memset(buf, '\0', size);
> > > +     ret = madvise(buf, size, MADV_COLLAPSE);
> > > +     if (ret) {
> > > +             prterr("madvise collapse for buf");
> > > +             free(buf);
> > > +             return NULL;
> > > +     }
> > > +
> > > +     *buf_size = size;
> > > +#endif
> > > +     return buf;
> > > +}
> > > +
> > > +static void
> > > +init_buffers(void)
> > > +{
> > > +     int i;
> > > +
> > > +     original_buf = (char *) malloc(maxfilelen);
> > > +     for (i = 0; i < maxfilelen; i++)
> > > +             original_buf[i] = random() % 256;
> > > +     if (hugepages) {
> > > +             long hugepage_size = get_hugepage_size();
> > > +             if (hugepage_size == -1) {
> > > +                     prterr("get_hugepage_size()");
> > > +                     exit(102);
> > > +             }
> > > +             good_buf = init_hugepages_buf(maxfilelen, hugepage_size, writebdy,
> > > +                                           &hugepages_info.good_buf_size);
> > > +             if (!good_buf) {
> > > +                     prterr("init_hugepages_buf failed for good_buf");
> > > +                     exit(103);
> > > +             }
> > > +             hugepages_info.orig_good_buf = good_buf;
> > > +
> > > +             temp_buf = init_hugepages_buf(maxoplen, hugepage_size, readbdy,
> > > +                                           &hugepages_info.temp_buf_size);
> > > +             if (!temp_buf) {
> > > +                     prterr("init_hugepages_buf failed for temp_buf");
> > > +                     exit(103);
> > > +             }
> > > +             hugepages_info.orig_temp_buf = temp_buf;
> > > +     } else {
> > > +             unsigned long good_buf_len = maxfilelen + writebdy;
> > > +             unsigned long temp_buf_len = maxoplen + readbdy;
> > > +
> > > +             good_buf = calloc(1, good_buf_len);
> > > +             temp_buf = calloc(1, temp_buf_len);
> > > +     }
> > > +     good_buf = round_ptr_up(good_buf, writebdy, 0);
> > > +     temp_buf = round_ptr_up(temp_buf, readbdy, 0);
> > > +}
> > > +
> > >  static struct option longopts[] = {
> > >       {"replay-ops", required_argument, 0, 256},
> > >       {"record-ops", optional_argument, 0, 255},
> > > @@ -2883,7 +3023,7 @@ main(int argc, char **argv)
> > >       setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
> > >
> > >       while ((ch = getopt_long(argc, argv,
> > > -                              "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > > +                              "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> > >                                longopts, NULL)) != EOF)
> > >               switch (ch) {
> > >               case 'b':
> > > @@ -2916,6 +3056,14 @@ main(int argc, char **argv)
> > >               case 'g':
> > >                       filldata = *optarg;
> > >                       break;
> > > +             case 'h':
> > > +#ifndef MADV_COLLAPSE
> > > +                     fprintf(stderr, "MADV_COLLAPSE not supported. "
> > > +                             "Can't support -h\n");
> > > +                     exit(86);
> > > +#endif
> > > +                     hugepages = 1;
> > > +                     break;
> >
> > ...
> > if we could change this part to:
> >
> > #ifdef MADV_COLLAPSE
> >         hugepages = 1;
> > #endif
> >         break;
> >
> > to avoid the test failures on old systems.
> >
> > Or any better ideas from you :)
> 
> Hi Zorro,
> 
> It looks like MADV_COLLAPSE was introduced in kernel version 6.1. What
> do you think about skipping generic/758 and generic/759 if the kernel
> version is older than 6.1? That to me seems more preferable than the
> paste above, as the paste above would execute the test as if it did
> test hugepages when in reality it didn't, which would be misleading.

Hi Joanne,

Sorry I'm still on my holiday, reply a bit late and hastily. At first,
your patch has been merged, the merged case numbers are g/759 and g/760,
you can rebase to latest for-next branch and write new fix patch :)

Then, you're right, above code change is bit rough;) Maybe there's a way
to _notrun if MADV_COLLAPSE isn't supported?

Thanks,
Zorro

> 
> 
> Thanks,
> Joanne
> 
> >
> > Thanks,
> > Zorro
> >
> > >               case 'i':
> > >                       integrity = 1;
> > >                       logdev = strdup(optarg);
> > > @@ -3229,15 +3377,7 @@ main(int argc, char **argv)
> > >                       exit(95);
> > >               }
> > >       }
> > > -     original_buf = (char *) malloc(maxfilelen);
> > > -     for (i = 0; i < maxfilelen; i++)
> > > -             original_buf[i] = random() % 256;
> > > -     good_buf = (char *) malloc(maxfilelen + writebdy);
> > > -     good_buf = round_ptr_up(good_buf, writebdy, 0);
> > > -     memset(good_buf, '\0', maxfilelen);
> > > -     temp_buf = (char *) malloc(maxoplen + readbdy);
> > > -     temp_buf = round_ptr_up(temp_buf, readbdy, 0);
> > > -     memset(temp_buf, '\0', maxoplen);
> > > +     init_buffers();
> > >       if (lite) {     /* zero entire existing file */
> > >               ssize_t written;
> > >
> > > --
> > > 2.47.1
> > >
> >
> 


