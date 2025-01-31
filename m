Return-Path: <linux-fsdevel+bounces-40514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C742CA24393
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 21:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413A2165DA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 20:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647811F238D;
	Fri, 31 Jan 2025 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PkqyGpZu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C295E1DA4E
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 20:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738353617; cv=none; b=ut6ntCq0QH+3bzCpkYO2Py3lB4ZuSefKo4orYZ+baxm9AEWLkfSXmlAivr5xOWVpdUo/yrCn6+l/xFLEChKMRoMc/EFJYe9uhEd8v1PmesjH2Feiq6SwqZC4i7vhiV3lTdeoD6X+RJOl+SszTJ3hLNc9V6ZUUzIGCPFAnR0XvvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738353617; c=relaxed/simple;
	bh=mESJj9WNZAGhoP88PwXyk6SgSBIq1RXBtiH16frMzTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8YvQ7Y5SP9Q5fLQ0Q5Re4dM4bqyJ+QfQZTcsBT6YHauAvWyPS5n4pnkYV8RfCHcVdpMSEN3VTbijsf2WvJieDjnZCU3JuwuzqEQtNMzcuxaNDu4drIQK0yODUUwpatJ2W7mk+W7U/GxIaAGA13JduAzveqbiMcxkLGSL3oCkdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PkqyGpZu; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaf57c2e0beso495833666b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 12:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1738353614; x=1738958414; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1VEMyzp2lsoEGf8wTQK/Tt97K6OMqjZreNFMoOiXZ5E=;
        b=PkqyGpZuwGS/wpbROhdz8z5McFIgW+efDt7VOWo+8+EBaZmgbwLuVIAsKfn77LTN4S
         kxXKR1lYAf0bJu/tinnB5eOaMiHOGg8DekjXjyiHZarphhNDrDPjhd1cSIfntRJMFpFF
         fVV3KUQnAXl//IaBWNcSBH294omfQh1KkBSbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738353614; x=1738958414;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1VEMyzp2lsoEGf8wTQK/Tt97K6OMqjZreNFMoOiXZ5E=;
        b=rr66eEUfnHnE+gTkXz7DfwodVPwEESEfFM2OnCUOYO8kX/s6IPFuzrNZ0agju3nM/E
         WK8rOyr44oIU19kYAy0XHaqXw76IazozNFezICUi1J64E14P6B1hvlACtfVVZolzRFS6
         n32jF1bxAHGJ7BtkPJAMwc6bUFvwVGE90lapp7MzG4ATOi5rRosiXt//XMSMDwK2vY3k
         Um/75AFvdnXPpdYvfF58Pdh9FBPJgyH4JS+Xp99q1FXf8y8IuGTAWpjlDilcPxCxVb7U
         7m+AOdrhtFiM6icrH9YyxQwT/KL2gXN0SW+dirD6afcc0fatEK79mIhX4mMxvz2SuHwQ
         qK5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkoS7A7fyKojUquoI28ujIXhwDcpqiCR9E1EL/YlWJR2Ashq3X4qgVpdiys2eg6z6WcgLs3cWt16GpMp3P@vger.kernel.org
X-Gm-Message-State: AOJu0YwqERt8bF5hP8PdBlszeYlIEev4CERgyATWqY8d28QKO5XGeYbK
	dW0lSBD0RbMAilh2vKVDJPPV5nwya/t8Nzv7XY654fi+l2K376fyNHvTDXDLl/JUw/z0pmhVg7/
	YUE4=
X-Gm-Gg: ASbGncscU9P4IxhI/fujuv2oBsmj/3WoAsUyFA3fLcK1YkD9CDGYHrKkL28pk9topd2
	5q47u1amnwWhy1ojEjkn7QowLmItQH81BFpWnX16UN3iajSjXgHrewufANqWjqScSHWxUcXm5Gp
	4vqgfIH3oFdZMlG//yEigjtgEsRR2nM7/cDHosq02RWv4Y+kkgIvhx+/C6F4pDRn/9ib39BESfa
	IBBojSWpsIiedRpZqFepXow3Pww/L04jVlliPkz+GYk+IWgfa07DQlTzJ2Z4rgjsFbpcZNwE+Z2
	1+RJph1BTxkM5Ome/t4RGdXWMWwrd8T2v1Zj4rqveZdyYY00FGda0DAoXo/CuV3yFg==
X-Google-Smtp-Source: AGHT+IE0FCfhtInT+HZfGZLoqhPLZFcbqXXThRWtfQvyDntGb+TJakk8izxQHFaBVkIYhdL89WEkcw==
X-Received: by 2002:a17:906:4788:b0:aa6:7a81:3077 with SMTP id a640c23a62f3a-ab6cfdc6163mr1069023866b.54.1738353613498;
        Fri, 31 Jan 2025 12:00:13 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47d27aesm344410166b.60.2025.01.31.12.00.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 12:00:12 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3bdccba49so3940659a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 12:00:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXRdNaPxT3pUgmXSBFkv8C78Bea3SXijjYBA+YUByG0uQD6uXYLJbva0RPwSthswFjFzzT+7P9Qo6qZQe9O@vger.kernel.org
X-Received: by 2002:a05:6402:2709:b0:5da:1448:43f5 with SMTP id
 4fb4d7f45d1cf-5dc5effcc33mr12325224a12.31.1738353612239; Fri, 31 Jan 2025
 12:00:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731684329.git.josef@toxicpanda.com> <9035b82cff08a3801cef3d06bbf2778b2e5a4dba.1731684329.git.josef@toxicpanda.com>
 <20250131121703.1e4d00a7.alex.williamson@redhat.com>
In-Reply-To: <20250131121703.1e4d00a7.alex.williamson@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 31 Jan 2025 11:59:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjMPZ7htPTzxtF52-ZPShfFOQ4R-pHVxLO+pfOW5avC4Q@mail.gmail.com>
X-Gm-Features: AWEUYZmJHVy_un_wj0EXjvnXlSLyiKtpaVCBTRVD7w7Khb3Vui_AFXvwFXKGqO4
Message-ID: <CAHk-=wjMPZ7htPTzxtF52-ZPShfFOQ4R-pHVxLO+pfOW5avC4Q@mail.gmail.com>
Subject: Re: [REGRESSION] Re: [PATCH v8 15/19] mm: don't allow huge faults for
 files with pre content watches
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, amir73il@gmail.com, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org, Peter Xu <peterx@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Jan 2025 at 11:17, Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> 20bf82a898b6 ("mm: don't allow huge faults for files with pre content watches")
>
> This breaks huge_fault support for PFNMAPs that was recently added in
> v6.12 and is used by vfio-pci to fault device memory using PMD and PUD
> order mappings.

Surely only for content watches?

Which shouldn't be a valid situation *anyway*.

IOW, there must be some unrelated bug somewhere: either somebody is
allowed to set a pre-content match on a special device.

That should be disabled by the whole

        /*
         * If there are permission event watchers but no pre-content event
         * watchers, set FMODE_NONOTIFY | FMODE_NONOTIFY_PERM to indicate that.
         */

thing in file_set_fsnotify_mode() which only allows regular files and
directories to be notified on.

Or, alternatively, that check for huge-fault disabling is just
checking the wrong bits.

Or - quite possibly - I am missing something obvious?

             Linus

