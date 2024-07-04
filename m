Return-Path: <linux-fsdevel+bounces-23173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B797C927F2A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 01:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2975B1F226F6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 23:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FB0143C6D;
	Thu,  4 Jul 2024 23:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="QRnaDhAu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4459813D243
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jul 2024 23:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720136078; cv=none; b=H1R+8xZl8qMeoJhvfVzdEWJlrth3EHUQuCl9NmygayjaD8QgymBsAB3w0OelmY1+Xa//QvAsqivAAtofsYaODIe2sFIFmRQ2q6VPnp5zmocCMgXOPEUT644I7aVO4809dgDdWAbuR16uc2isZXOE4E6yPHG7V5uocc7Q9YjxVfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720136078; c=relaxed/simple;
	bh=uFl3AdUYemHzj9KdoLmeiiMGhtBNTzYbYtwxD50zcG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CusjAXv9bjkgiZFg7SXTwqKh+pDKP4HBSksj8949jmquGgJFwsKAYvr4r2iANtGacBSB1NZcLVh1hEitrflj9RKGUe+d4wlKzidRrgqIjTBgPDoXwRMJO0dErQ0XUZqey7wmsUQ9LeObj+20wRC1x0rrUVuMA3Oh/ZCXyU9Ngbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=QRnaDhAu; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d853e31de8so597149b6e.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jul 2024 16:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1720136076; x=1720740876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dljpTEIW3bUCTF22+iL12CHvB2MQxQGsJUr215F+SI4=;
        b=QRnaDhAur/HXt/q8MHlNAZ5hNhiIwWfwy7AmiGmZwXEVhkpxuybiIceG7TiPZ5xYH9
         AA70VvDG53bGMI3ZARTBaPq1qFBSCbiZYaVFtCZy2w1YlQtwwwLK8Gh9ElqDCg0ouese
         8cXr+pmNDy9Lz7uGmlI7IPPP88dYweV+AC1G4cq5xj7iKYh0dBX3EJdWvkfSVG8s4GD8
         SQVyzDLqtLDBvzDU4WQUzbb4GCGB+sZLcDLzeIQOa4gJIpYSrrzCgs+DKWtKQ3IZGruI
         fHZKAsr6e+bCOqpzAk14IJ3OqON7Ek/Bn0Y8iDo1b0240OXtznR/UjkgPuZaHp9NfuoV
         UMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720136076; x=1720740876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dljpTEIW3bUCTF22+iL12CHvB2MQxQGsJUr215F+SI4=;
        b=oXZYLY8zJmy+Kpcbg+QOy5hJkrZSp5XLj8/RJuMT6Jp6BfiXN2dGYg9S4eXv+q7Upm
         z/GFTNRH1LUQtaziQwB71vNLRLu+bmb5N/dbhTtE/qlEKqGUo+3IhPSHvIckBLFyY4LU
         DupLCS1h7r2WinYAuK9NvyrsnETS0So3WZZ5iXscxrCPIU6mT4O6ibhEqamwJ6S50pYJ
         oi/zPqDG46xcbiAxChswUGutVvZODmDTLDdT5IrUHwjUFOuuZypN1j496LHcDB5HyJGF
         PgasHNBMl1f7mE2eoHWOCJLNYDrv2XDfiE5I5p8J39OP+gyM372apZCW3kTmUF3N5ZMB
         wygg==
X-Forwarded-Encrypted: i=1; AJvYcCUGT7kjCrhND4Vf6Sljr/px5UUv6TjP4M6gnzYkRKOoh4VVtLf5UlBTCT83vhwcFNzWK9pcC7WCV6TiDNJujEOX9JUsRDl0EQB+FjlLIA==
X-Gm-Message-State: AOJu0YziY/tkrvgDBidGN3+Yv9GC4xeJJIWkQdG1oPhR/9eZGCVCnXyy
	JN807SGCOkPlqU+6/HMTdK5MsWWkRPpfF1a7TiQMvJIykI2LDUTgJ/Ka8WD5sZQ=
X-Google-Smtp-Source: AGHT+IFNIbaahogwbzijyX3zYF3lr3s2hn9+6ybBl0AP8I3qaAHGF+j9b1pdlCKXaFl+LFyp4Jsh7Q==
X-Received: by 2002:a05:6808:1a1d:b0:3d5:6599:ae2b with SMTP id 5614622812f47-3d914c45476mr3932615b6e.8.1720136076352;
        Thu, 04 Jul 2024 16:34:36 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b0c18237bsm356018b3a.12.2024.07.04.16.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 16:34:35 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sPVyD-004NR1-1Z;
	Fri, 05 Jul 2024 09:34:33 +1000
Date: Fri, 5 Jul 2024 09:34:33 +1000
From: Dave Chinner <david@fromorbit.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Matthew Wilcox <willy@infradead.org>, Hongbo Li <lihongbo22@huawei.com>,
	muchun.song@linux.dev, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hugetlbfs: support tracepoint
Message-ID: <ZocxiSIQdm0tyaVG@dread.disaster.area>
References: <20240704030704.2289667-1-lihongbo22@huawei.com>
 <20240704030704.2289667-2-lihongbo22@huawei.com>
 <ZoYY-sfj5jvs8UpQ@casper.infradead.org>
 <Zoab/VXoPkUna7L2@dread.disaster.area>
 <20240704101322.2743ec24@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704101322.2743ec24@rorschach.local.home>

On Thu, Jul 04, 2024 at 10:13:22AM -0400, Steven Rostedt wrote:
> On Thu, 4 Jul 2024 22:56:29 +1000
> Dave Chinner <david@fromorbit.com> wrote:
> 
> > Having to do this is additional work when writing use-once scripts
> > that get thrown away when the tracepoint output analysis is done
> > is painful, and it's completely unnecessary if the tracepoint output
> > is completely space separated from the start.
> 
> If you are using scripts to parse the output, then you could just
> enable the "fields" options, which will just ignore the TP_printk() and
> print the fields in both their hex and decimal values:
> 
>  # trace-cmd start -e filemap -O fields
> 
> // the above fields change can also be done with:
> //  echo 1 > /sys/kernel/tracing/options/fields
> 
>  # trace-cmd show
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 8/8   #P:8
> #
> #                                _-----=> irqs-off/BH-disabled
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| / _-=> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>             less-2527    [004] ..... 61949.896458: mm_filemap_add_to_page_cache: pfn=0x144625 (1328677) i_ino=0x335c6 (210374) index=0x0 (0) s_dev=0xfe00003 (266338307) order=(0)
>             less-2527    [004] d..2. 61949.896926: mm_filemap_delete_from_page_cache: pfn=0x152b07 (1387271) i_ino=0x2d73a (186170) index=0x0 (0) s_dev=0xfe00003 (266338307) order=(0)
>      jbd2/vda3-8-268     [005] ..... 61954.461964: mm_filemap_add_to_page_cache: pfn=0x152b70 (1387376) i_ino=0xfe00003 (266338307) index=0x30bd33 (3194163) s_dev=0x3 (3) order=(0)
>      jbd2/vda3-8-268     [005] ..... 61954.462669: mm_filemap_add_to_page_cache: pfn=0x15335b (1389403) i_ino=0xfe00003 (266338307) index=0x30bd40 (3194176) s_dev=0x3 (3) order=(0)
>      jbd2/vda3-8-268     [005] ..... 62001.565391: mm_filemap_add_to_page_cache: pfn=0x13a996 (1288598) i_ino=0xfe00003 (266338307) index=0x30bd41 (3194177) s_dev=0x3 (3) order=(0)
>      jbd2/vda3-8-268     [005] ..... 62001.566081: mm_filemap_add_to_page_cache: pfn=0x1446b5 (1328821) i_ino=0xfe00003 (266338307) index=0x30bd43 (3194179) s_dev=0x3 (3) order=(0)
>             less-2530    [004] ..... 62033.182309: mm_filemap_add_to_page_cache: pfn=0x13d755 (1300309) i_ino=0x2d73a (186170) index=0x0 (0) s_dev=0xfe00003 (266338307) order=(0)
>             less-2530    [004] d..2. 62033.182801: mm_filemap_delete_from_page_cache: pfn=0x144625 (1328677) i_ino=0x335c6 (210374) index=0x0 (0) s_dev=0xfe00003 (266338307) order=(0)

Yes, I know about that. But this just makes things harder, because
now there are *3* different formats that have to be handled (i.e.
now we also have to strip "()" around numbers).

-Dave.
-- 
Dave Chinner
david@fromorbit.com

