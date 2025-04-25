Return-Path: <linux-fsdevel+bounces-47377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43564A9CD6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 17:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931A74C4102
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 15:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA89D288CA3;
	Fri, 25 Apr 2025 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+Idr3dD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3D728D850
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745595908; cv=none; b=EYdXCkNPGUVAEoz/h3/XHY8bZtWXmUX/oqRMRgwknILghFfD+JyPQ49t2VMBGNXJLKTBTM3vrea+k+HocmnOZB/LkfV5pzP+DVu01TMUbfc8++AnxCjBS+XwLRqrlNwo+vVsQV0Ruf0RYJwQZwfovmDkOMo9FTT43+/jfshkZQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745595908; c=relaxed/simple;
	bh=7Qr54RLIIUURTVvUAneM4I3kDi4Hksd7DxjUOsMoHvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzXUuVLNEMg8I9spMWfAT1bNr0OjXh42KMxK7Zgs/PDzWHYxDJtqgNC66sWFSjHVJJGhoS8Z6SPyZBZciO2y6Tim3bNQ79Eod/Mm0OI7bo5hGBJkwgiu2l2OEC45eOmMCdHknihXCig+MyS2aA8CxLqHSFURj1sV4xEVBA+Fv4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+Idr3dD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745595905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hiof3A3cTkiDcDIiwDJpp213Ent/m5U6m6lMi/Ixq+s=;
	b=J+Idr3dDY3yZXIvFOLJElj7UCsV841Ivir9QPIa4bR9qS56PSnOLxc6F0+oQ3XikIQYc1r
	Uka26d1TX6N6TFKGT7HK/+gLav4Jt7UMjvTB4Mw/Oc5HzEbY+RZXA4DtlMUcXKgPhlxVpp
	sND+9W8/iX+vFV0I3SFLHaIGhOrmTUM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-FXbjWrjtMVuSZ6FRavAMeQ-1; Fri, 25 Apr 2025 11:45:03 -0400
X-MC-Unique: FXbjWrjtMVuSZ6FRavAMeQ-1
X-Mimecast-MFC-AGG-ID: FXbjWrjtMVuSZ6FRavAMeQ_1745595902
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5d608e703so440421885a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 08:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745595902; x=1746200702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hiof3A3cTkiDcDIiwDJpp213Ent/m5U6m6lMi/Ixq+s=;
        b=UWXWA9HS3f5DpnYVZwImIUK+3YVccc9RsEGeroYhLHE/B2nIa79RhjWvrH6A1EUTsV
         KyrzxQSvZv0dQUkjdSeyC1q2ePGjdrTUyNf69C5QyxmscQAPjFhmCPfsOc7vsZ2bXUK8
         uAMVuHB6eoMA/sM2j+Yh/0O5nQoKA8ZuH1Lnv4mVNcw732+bN209Lw8Gm+ge/dgeNt61
         j9tb5WVkdO/q3nrySHGK3BKUCc56Q7m0BWbtswcZpAPdh+OwTVO8a7w7ABiZsk6Btooj
         uoy/g19pHJb+8mpBfZEH40kQQBLoRzCPnNZmlNKQu47gGcI0i5xBD+MDLejj5JCO5CFa
         2/zg==
X-Forwarded-Encrypted: i=1; AJvYcCUj/Ws3yc6ydPRUjtzYJ1+C6ZQY2qSEfwhcCMx5lXavQyDKmwM9WSkPyulfZKcebwoC1nk0dKMtpwmfmBH2@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9rpHMkQyHpL95ocakgZykk2Ou5t4DnWAxu8tejCCXRiXAKifb
	z3iJTLoIkSCTc3LVuZ7sBKxZVksONw3InlbtZ4VcMFx4yLiwvSWNECKsgSM42W2bdGSG2XWvoRo
	oQU4/Iqug9wJyY4H1VDq9b2TDaAGbk5R6FIPJoAAhMyqLEMqu1KMEzLncgCWYyCY=
X-Gm-Gg: ASbGncvqxVJirBSNdm2PSC7TNM/7sADKjdbBRb/eDVX7NUz7aOVFAB6zzFCbeXIVZhN
	V/aEqE6NwWNgq0mqKkJYVQElP6yfET9sRDu41ZcrmxgPm1FjJ3fVnsEFRidKMEFiOaZXJ8IFfHf
	Lrhi20bkm3Xmqai84QsrTTF5ZhUorh9xmRXKxUipBm9xc0mSkoKPCBbjsY9GjgthgV1iGB+NKEc
	IBGH4YfWN8lmvSShuZToP4HdIEv9crtwyEGlLgGphQdX3xP3Wjy6MchfZZBeCQBO3pmFjAZWCeT
	oAc=
X-Received: by 2002:a05:622a:315:b0:477:41e5:cb8d with SMTP id d75a77b69052e-4801e9e3639mr37436571cf.44.1745595902624;
        Fri, 25 Apr 2025 08:45:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMtGEXUdc1pttInszqwGo8CcuEvmRkp5U7mI9l29hGjtQVzppVl01ysYhGDpH/L9C07a++UQ==
X-Received: by 2002:a05:622a:315:b0:477:41e5:cb8d with SMTP id d75a77b69052e-4801e9e3639mr37436391cf.44.1745595902345;
        Fri, 25 Apr 2025 08:45:02 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9efdaa41sm26715741cf.19.2025.04.25.08.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 08:45:01 -0700 (PDT)
Date: Fri, 25 Apr 2025 11:44:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/userfaultfd: prevent busy looping for tasks with
 signals pending
Message-ID: <aAut-ohM5Lt2uH4I@x1.local>
References: <27c3a7f5-aad8-4f2a-a66e-ff5ae98f31eb@kernel.dk>
 <20250424140344.GA840@cmpxchg.org>
 <aAqCXfPirHqWMlb4@x1.local>
 <aAqUCK6V1I08cPpj@casper.infradead.org>
 <aAqxAX2PimC2uZds@x1.local>
 <aAsVBIIUvXJ6KQ5d@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aAsVBIIUvXJ6KQ5d@casper.infradead.org>

On Fri, Apr 25, 2025 at 05:52:20AM +0100, Matthew Wilcox wrote:
> Because "interruptible" means it can be interrupted by inane stuff like
> SIGWINCH and SIGALRM.  And then we return from a page fault prematurely
> and can't actually handle the situation, so we end up going back into the
> page fault handler anyway having accomplished nothing other than burn CPU.
> 
> At least it's better than interruptible system calls which just gets
> you short reads, corrupted data and crashing programs.

I see where it came from now, thanks.

IIUC it'll be a major spinning issue only if the fault is generated from
the sighandler itself which spins on its own. The hope is that sighandler
should almost always be suggested to be as tiny as possible, to make it
unlikely to happen.  Said that, it's a valid point indeed.

Maybe we should make FAULT_FLAG_INTERRUPTIBLE a hint rather than a request
to handle_mm_fault(), so the internal of page resolution can decide whether
to respect the hint.

Thanks,

-- 
Peter Xu


