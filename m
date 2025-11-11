Return-Path: <linux-fsdevel+bounces-67787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B09C4B1E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 03:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D53A74FDF5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 01:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F305305043;
	Tue, 11 Nov 2025 01:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKaReZAf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fL9Fbzvb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661CE1E9B3D
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 01:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762826029; cv=none; b=CPnsrPrr9bcUc5Rpp/3fWoTrIK9Z7D9FpBsZGSQmDRbhRLO/t7n+LJP0DobsnKHQHvN9AMC0ZlQ5+KMfeHLJAyu8PFtiNHs6mgBweOJXjxzqyWvuLVjJbAid1g0lP+UpFG6pgkVcA0tSkPJmV/VOcDi5CqqVcXvwYjUm9JMpPsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762826029; c=relaxed/simple;
	bh=SPfbF1enqcwOJRfEotXqWEZmbDB6l5+fT/yGsufoUc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Beck6aA7enBFcRqCcmWqSJyeNn+wXwvlqhmRwFS+4JMP8o8Df+XORYLsKbyUcm3FCpJd1+Q8rSzEvX5/+oDws8j2csWj1z0lOwMMXr5jjh0hrPy0gxoaFePXVTsDxZDhKLWRnODrW3/VLMrXbV90IRopNrsdjU6Hcn9Lf5R5diA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZKaReZAf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fL9Fbzvb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762826026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j3XklV9O6JekcN95bHXyedJHLFaMcI+Z8eQK/xCQbnU=;
	b=ZKaReZAfPgXF2+zHfVw2FnS9IwpLjnZj1XBNE8cCKukO4U8RiqRRgBWgVnhQNkMbq6Rjx/
	EEsUAM1/9Ebh2iCJGxWJDS5Tna6bOGo6L+93IzUkvQVWFmBeuo+7PwUtPJixfOiP5Mncbs
	Ute//eDT7ZSHow2N2ftVLGZHYb6tpyQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-Obn9CC5MMvadWGH4LG6GRw-1; Mon, 10 Nov 2025 20:53:44 -0500
X-MC-Unique: Obn9CC5MMvadWGH4LG6GRw-1
X-Mimecast-MFC-AGG-ID: Obn9CC5MMvadWGH4LG6GRw_1762826023
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-297dde580c8so67866295ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 17:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762826023; x=1763430823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j3XklV9O6JekcN95bHXyedJHLFaMcI+Z8eQK/xCQbnU=;
        b=fL9FbzvbaqQlZgdGTSUL6DDDXPNyHSYyL8Xs4JHrR7OupVSeqNkEbfL1UOkgSelAF2
         PXkAzl8jp9Qj1f9jtt+6jOrw9ZProDxE2QEpq5GbIXY/UWjGUtyI8AUzw/TDHOXBjGeT
         NMCFB66tDZ3k1xwtjXCj4nI072ZF03krBY2HBKydRAqteKQlYIxImAhZcbJNtbTZYbT/
         x11xvSeyyZpQBWZXV/M3bNOZXQ7il9p3bFunbPpdGs2QfTWQ5By7/hI6j0JuoR6T7Bg2
         Y+N0WtnAhK2wttJ31oXi2UM2eFcStUkXfSzDMsLGvGCq1uk8msFFvFLvo9wZTKI4Taf4
         yEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762826023; x=1763430823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3XklV9O6JekcN95bHXyedJHLFaMcI+Z8eQK/xCQbnU=;
        b=I9scs3QHWxMLpdl4Kfiyn+Xo+jBt852mRiBJQJ1yXoWzwZlsCmrgOUiJlOk8IYtcIv
         xfwEB+yzFqZrHG0kzrqvCVV+WfMtXvTDrJjukIYdQXigX96px4jeDvqoxey7EcgzEH25
         3eyMojavQBTQ6e5fPMYnIVgZxmObRReqv95Zj5+BD/gj184G3CHgge8Jj9hTH5GUWEbG
         qoz0L91890PfsbFSkw3J4HSjOMnv4plvQ+Y0u+QZhy0JZ/h2yp7Ufqy3p9fmN7ZvLCh5
         N6nfmunhFx0XIzfmiIoRmaNiRkuHhJLhXIxjnOzCCyZLmtB9gN7Lxbg9AHO8cZNIwyXs
         vQmw==
X-Forwarded-Encrypted: i=1; AJvYcCUSbOVIdOwelF/pLJga7oWTqyL7/hd7x3S+ve2+A8Kh8qT2FnJIiyIhh+WhCzF8gYCeY23jkE6xF1n44sOS@vger.kernel.org
X-Gm-Message-State: AOJu0YwrlW5Iqq8iNa2Pi9nVwAF6WR3UVXApagDpocedqWJqexFOFtIj
	Am1AdaUGfwXpMliQ7JSshYhg5pXGkPR6eppUy3J9QIAzcZdbcMS/+gXO2ogYpUzObdc9NC/+Z0T
	xrh9X4P/U9cd18HIhb/E0lcRaYz+0L+E3yCfyLwM+C3ML8i57bRsdEshp5Y1dLNJ4LdE=
X-Gm-Gg: ASbGncuxw7xqQxWdL9Y1EpAfNLK2OlFNd6MJO8FRgW3yuPlugzmvnL/pCB/nFEdGoz/
	ScEm2B5mHy4Pd1CCVOure7x76Y2iCyaTr3ubATXq95kRNo2JV3pxc4GxG50T3NVQF18k2uQIWcw
	XqKuCUkrjOovNci5VuwJJwia39bf1apBEX8vGiBk14VU9t6IgZDHHXdmMnKL0WdDUbNB7HE4eBS
	V/cmjYNVNB4AY52Hk6jmrUFXdObH0H593LtEwW9QFpeVE34aEmPiniLMg/83t3BtzCBtNioZaDf
	q7tXhIW5lkxijZz815/rdrMUZWtUHcrAXAdJ0S13F0xuYHokDUZOZztwdIGIIh673qjN6SO3xV4
	Q4jX3C4n9aflZAv8BpRTgciyC90p6A8HmxMM0FKI=
X-Received: by 2002:a17:902:f605:b0:298:68e:4043 with SMTP id d9443c01a7336-298068e42e5mr92058405ad.14.1762826023004;
        Mon, 10 Nov 2025 17:53:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGw9L6g4D6sX0IvAjppdudhuXGvA+ISsah2FfrH2akNkOHl0K3UoiaaaRBuHYOdHlzQV1taQ==
X-Received: by 2002:a17:902:f605:b0:298:68e:4043 with SMTP id d9443c01a7336-298068e42e5mr92058065ad.14.1762826022554;
        Mon, 10 Nov 2025 17:53:42 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096b8f4sm160191885ad.10.2025.11.10.17.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 17:53:41 -0800 (PST)
Date: Tue, 11 Nov 2025 09:53:36 +0800
From: Zorro Lang <zlang@redhat.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "tytso@mit.edu" <tytso@mit.edu>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"wqu@suse.com" <wqu@suse.com>,
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] Why generic/073 is generic but not btrfs specific?
Message-ID: <20251111015336.dz6um6vqpp3qxn3h@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <92ac4eb8cdc47ddc99edeb145e67882259d3aa0e.camel@ibm.com>
 <fb616f30-5a56-4436-8dc7-0d8fe2b4d772@suse.com>
 <06b369cd4fdf2dfb1cfe0b43640dbe6b05be368a.camel@ibm.com>
 <a43fd07d-88e6-473d-a0be-3ba3203785e6@suse.com>
 <ee43d81115d91ceb359f697162f21ce50cee29ff.camel@ibm.com>
 <20251108140116.GB2988753@mit.edu>
 <afcf903f52393132c98a79726d9b5f51696e736d.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afcf903f52393132c98a79726d9b5f51696e736d.camel@ibm.com>

On Mon, Nov 10, 2025 at 07:41:40PM +0000, Viacheslav Dubeyko wrote:
> On Sat, 2025-11-08 at 09:01 -0500, Theodore Ts'o wrote:
> > On Thu, Nov 06, 2025 at 10:29:46PM +0000, Viacheslav Dubeyko wrote:
> > > > > Technically speaking, HFS+ is journaling file system in Apple implementation.
> > > > > But we don't have this functionality implemented and fully supported on Linux
> > > > > kernel side. Potentially, it can be done but currently we haven't such
> > > > > functionality yet. So, HFS/HFS+ doesn't use journaling on Linux kernel side  and
> > > > > no journal replay could happen. :)
> > 
> > If the implementation of HJFJS+ in Linux doesn't support metadata
> > consistency after a crash, I'd suggest adding HFS+ to
> > _has_metadat_journalling().  This will suppress a number of test
> > failures so you can focus on other issues which arguably is probably
> > higher priority for you to fix.
> > 
> > After you get HFS+ to run clean with the journalling tesets skipped,
> > then you can focus on adding that guarantee at that point, perhaps?
> > 
> > 
> 
> Yes, it makes sense. It's really good strategy. But I've decided to spend couple
> of days on the fix of this issue. If I am not lucky to find the quick fix, then
> I'll follow this strategy. :)

Hi Slava,

fstests doesn't have an offical HFS+ supporting report (refer to README), so if you
find some helpers/cases can't work on hfs/hfsplus well, please feel free to modify
them to support hfs/hfsplus, then add hfs/hfsplus to the supporting list (in README)
after we make sure it works :)

Thanks,
Zorro

> 
> Thanks,
> Slava.


