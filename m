Return-Path: <linux-fsdevel+bounces-50982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2170FAD1916
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 09:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2BEB166A9E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 07:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0444E280CFC;
	Mon,  9 Jun 2025 07:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gSpZqNtm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9071D63D3
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 07:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749454548; cv=none; b=TXxtp989njDO/vm0Z6rMxr/1fL7pa9c+mV4vtIau4CX8VEVvquT2b2a+F7IHv4gN17XWdy/yxLuWUHrazwilFGORD5LcAoq72lxjbqg2ozacX+xC3Z2qsNbffbO8jM1LCrYwTUWU1zygVgV5hOk4Zy6z6oK0F9IE9PiWIKN5S4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749454548; c=relaxed/simple;
	bh=6voCWdZWcG4RRH+vYohcvQyoOOny8z1Oe8Y1Z2MemY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKU38N05qUqbxbRmuj5ruVNtLNkFXwfbyzmKP75PBZ5jHWnAXvOuRoq4CKGPQC6JZlcT0WfQXGZnOX871AQPdZBIdeecEtHcPV8Y9mT8TFYI+pJ0k3bgysv9epPg1rsr3OYEX3AsmiNQDUWJgoe5HY5nmqfnu73A78rqucu10Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gSpZqNtm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-451d54214adso33155265e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Jun 2025 00:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749454544; x=1750059344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8RuWRqP0d99Xv1WKhTslXLfzi2R4jCLF5zn4rM3x2gk=;
        b=gSpZqNtmgwPQ232q6nNNnR26rS8Vt0d5cztD3XHkpbQSFh/hr9pkl4EKugNIXqWLLu
         Fb9/CzzuMgE+wqcTK8nwmS2n/ft6bqZ1ddGR5lzAUvR7JsR3tcObu/LXDLsRaxSFhem+
         gTskFd3nQn8qbizWxhi/lBGi4wB2tEwE67PeHB56voHO9AYm62Ui8Mi16MKJBo+0idJg
         xizuYBokQ++Sgxv3XVBViVelRefM4JljaLXWvXAbYsPCzHqr24Hw9B0FGB06NIcMbiFh
         Eg/ddnB+BaSkpryRtaJ8RDQHIt45+FQ99oqbYV13W3B64Lon36xJPjH6oRZxpYy3nFSf
         J9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749454544; x=1750059344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RuWRqP0d99Xv1WKhTslXLfzi2R4jCLF5zn4rM3x2gk=;
        b=RqKjbjR3O0S2Q1ZpIDjrW7hJRfvGCjydhIVOFXRuW2THZKrgeGMVwEl3K4H3Mi7eS4
         hv9plpYSBgHddgEh7je3toEfgpmuwpUK9EWgyK39h7uCPWvezoq+RNOZQVeyGYvLMZUQ
         01WqkPyenfW6seAS9q9fM/PDNXtemyFWgVu74PGUEXoaXWVp/7mau/vXtFDCfZ3RjJVH
         trJCk0JFmb39bxuTsObECOgxPlNAnF1++SM8AbCHTp8nFY7VCPZfcXpy/snLnW3ajmf6
         DE6sPR54gvDXuVQvd7UeMkCh20WdZthYcivosrC7nYxOAkOuI1PCtarO/TmaDYvKItbG
         o7/g==
X-Forwarded-Encrypted: i=1; AJvYcCUyf97V49itZFjHNxjVgyO+3SbvSKVXDtwaRQVk/GuBWhLqXmi4HkEl54zkmX7XDXTnBB0M7zQcqgDpPlGn@vger.kernel.org
X-Gm-Message-State: AOJu0YzMi/SQNOZT7FfZOZ1z3P96D+UPtZVnF974Id7oxCV9f/8xQqnx
	zpYEXPKyKKAeZrwjh6aFu9pzQvc03wMU5V1Yze30IHnR+y0WKRLwoF31nvwpna0/xHM=
X-Gm-Gg: ASbGncv5h/ThvCI1kbj93jKCuW2G5FuQa1ncxnkh5YjDNIKj/WHriyPNEst6F1xSYg9
	4uQDFbgEWC9kq4h5HGzAhczuc7BAyTn5Q7iREvVpjykm2Hcq8HU+nCS2A8EzlDTExEG5i18RdKt
	kWulXxfqmE13hv1ewGRrRgxMTBxf9aGdmYejN0ubdntikRkm7kgQMUjdOid8JON3gjLwFxcXfIW
	315Bqt6rkmqUaz2TG8lyce8KVJcmirSDDlOaxJoY50OE7P72vgEmWfsVO6xPw3OKSNnUncnVcDs
	Oh9vOQXql+6lzTExSzhtRsN5li9W/DvhVWfqeoqWbBcbk9qvYXEu4ebVFOosFZpOIuM8FZ0MI/g
	=
X-Google-Smtp-Source: AGHT+IF6DM1q4q8CPakAyqZNCbPDwJpamBu3whbTRqn03tXemtCu5+RQvYP709FhwnPjbnmjHYqPmA==
X-Received: by 2002:a05:600c:37cd:b0:442:d9f2:ded8 with SMTP id 5b1f17b1804b1-45201368cfcmr113234485e9.15.1749454543908;
        Mon, 09 Jun 2025 00:35:43 -0700 (PDT)
Received: from localhost (109-81-91-146.rct.o2.cz. [109.81.91.146])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-452f8f011c8sm97794095e9.3.2025.06.09.00.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 00:35:43 -0700 (PDT)
Date: Mon, 9 Jun 2025 09:35:42 +0200
From: Michal Hocko <mhocko@suse.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
	david@redhat.com, shakeel.butt@linux.dev,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, donettom@linux.ibm.com,
	aboorvad@linux.ibm.com, sj@kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: fix the inaccurate memory statistics issue for
 users
Message-ID: <aEaOzpQElnG2I3Tz@tiehlicka>
References: <f4586b17f66f97c174f7fd1f8647374fdb53de1c.1749119050.git.baolin.wang@linux.alibaba.com>
 <87bjqx4h82.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjqx4h82.fsf@gmail.com>

On Mon 09-06-25 10:57:41, Ritesh Harjani wrote:
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
> > On some large machines with a high number of CPUs running a 64K pagesize
> > kernel, we found that the 'RES' field is always 0 displayed by the top
> > command for some processes, which will cause a lot of confusion for users.
> >
> >     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
> >  875525 root      20   0   12480      0      0 R   0.3   0.0   0:00.08 top
> >       1 root      20   0  172800      0      0 S   0.0   0.0   0:04.52 systemd
> >
> > The main reason is that the batch size of the percpu counter is quite large
> > on these machines, caching a significant percpu value, since converting mm's
> > rss stats into percpu_counter by commit f1a7941243c1 ("mm: convert mm's rss
> > stats into percpu_counter"). Intuitively, the batch number should be optimized,
> > but on some paths, performance may take precedence over statistical accuracy.
> > Therefore, introducing a new interface to add the percpu statistical count
> > and display it to users, which can remove the confusion. In addition, this
> > change is not expected to be on a performance-critical path, so the modification
> > should be acceptable.
> >
> > In addition, the 'mm->rss_stat' is updated by using add_mm_counter() and
> > dec/inc_mm_counter(), which are all wrappers around percpu_counter_add_batch().
> > In percpu_counter_add_batch(), there is percpu batch caching to avoid 'fbc->lock'
> > contention. This patch changes task_mem() and task_statm() to get the accurate
> > mm counters under the 'fbc->lock', but this should not exacerbate kernel
> > 'mm->rss_stat' lock contention due to the percpu batch caching of the mm
> > counters. The following test also confirm the theoretical analysis.
> >
> > I run the stress-ng that stresses anon page faults in 32 threads on my 32 cores
> > machine, while simultaneously running a script that starts 32 threads to
> > busy-loop pread each stress-ng thread's /proc/pid/status interface. From the
> > following data, I did not observe any obvious impact of this patch on the
> > stress-ng tests.
> >
> > w/o patch:
> > stress-ng: info:  [6848]          4,399,219,085,152 CPU Cycles          67.327 B/sec
> > stress-ng: info:  [6848]          1,616,524,844,832 Instructions          24.740 B/sec (0.367 instr. per cycle)
> > stress-ng: info:  [6848]          39,529,792 Page Faults Total           0.605 M/sec
> > stress-ng: info:  [6848]          39,529,792 Page Faults Minor           0.605 M/sec
> >
> > w/patch:
> > stress-ng: info:  [2485]          4,462,440,381,856 CPU Cycles          68.382 B/sec
> > stress-ng: info:  [2485]          1,615,101,503,296 Instructions          24.750 B/sec (0.362 instr. per cycle)
> > stress-ng: info:  [2485]          39,439,232 Page Faults Total           0.604 M/sec
> > stress-ng: info:  [2485]          39,439,232 Page Faults Minor           0.604 M/sec
> >
> > Tested-by Donet Tom <donettom@linux.ibm.com>
> > Reviewed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Acked-by: SeongJae Park <sj@kernel.org>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > ---
> > Changes from v1:
> >  - Update the commit message to add some measurements.
> >  - Add acked tag from Michal. Thanks.
> >  - Drop the Fixes tag.
> 
> Any reason why we dropped the Fixes tag? I see there were a series of
> discussion on v1 and it got concluded that the fix was correct, then why
> drop the fixes tag? 

This seems more like an improvement than a bug fix.
-- 
Michal Hocko
SUSE Labs

