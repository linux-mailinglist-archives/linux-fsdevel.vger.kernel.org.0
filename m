Return-Path: <linux-fsdevel+bounces-68998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 353DBC6AF93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 18:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 36AE72CE98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 17:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91433537E9;
	Tue, 18 Nov 2025 17:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLoGzHJf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCBF30EF8E
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763487077; cv=none; b=i/qSyDvdDa5M9+T8SdRrU0MIXVusy4+SLlOr6vM4ZNEz6RYfALxOncL+RbnhYkmgomaa8MQGWPc7+f9jxBIkaJmoqJ9LAVFgg+31Ksbm7whr/9WBQ4ZJhIG7gTJwvVJ/4H85DzIAJ/Q1NXgnJtFpvEF2Ue938nK2sPh0/oNITFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763487077; c=relaxed/simple;
	bh=nhASVdDt4OdAwVAANU2bomnv6+IJT33HttvU1MpH8Lo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=SSXgcL0vReWWWFNsrvQpj5yQ1ZYQP027cWn1yTywTJgMOApmGFoRJWLmJ8nrmBvVYXQZcTYQmFBci85GYUjunfAoqIwk+kZ9SKBvnbMAr0qapP6HCR4BqWnXVz8cMXc49Qm2TCqEO9CKD2Z5duWGl7/yzyUVALqAs8B37GQufCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLoGzHJf; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-340a5c58bf1so4144953a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 09:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763487076; x=1764091876; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jJZHPmpfAYK3kOvAYzdDDouNFc3+GX3mg/4dP4wkGpE=;
        b=NLoGzHJfgXsbAIpeLOuT6H6thcbOWsDrkYUlxHE9fk3EaW4cGSmISVyDK/gU6ynD88
         N14Z9t/iBYvcVGGUJmeap1tNlmbkLAjhKlO+R0Dgqq2Is/zEvq+xKgVPOz5ZG5yPGTNM
         ubaLmhdYov6TNgBBIgKY995lAQtqIcbwfnFAi76HWg7vURciDFf/clqnmsX/E6xwn9ys
         HhzeJjSb/w6tbMbCjRS5qTE6A3g4D5uSTi50vWEpjslAIkTDywlrFQRmUKQfGoaiFbgV
         Yoju0NimoDihKurn/a1/7eNFWW7gMu4HWdBJazse1O9QWcZTXqRrQHyNqfB+W5W3kNjs
         8KRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763487076; x=1764091876;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJZHPmpfAYK3kOvAYzdDDouNFc3+GX3mg/4dP4wkGpE=;
        b=lSj4fKPK6IyNrq6jB8Vd1kUz7vhU/5TP6Rdfh3qNX+aiYQ/ZiYFQuxzd8iUiazjedn
         I7kZ1O8L5VsqsJRrdh5DZhH6soZerd1g3wSUhrNm02rbEZvKHaTfs37Nb1y+2js1yjuO
         Ffi4V9I3jW45hS/5xKeV2ej+QToqHFV7ITM8eo0N3cuzD9dZLEY3BomM/CWs50cXi/vK
         65f4RlQFJ98Fgh5V6olsgTOp7dzROlYtBfRVA9mhX8UK51C1fMa8gyB67cODSTVhObCh
         85WoOQichcDEyk1F9yKi5OjgT6KDMwMcGpbJ7ydgcmpJIYpkstF1TdvqJEJvRVaKGXZh
         EqPw==
X-Forwarded-Encrypted: i=1; AJvYcCVAZyXdbAuMFsL+yDnL508ayUGOQbEWho07g3Y7TFqd/wt32WmuKw/3DY+MGj4XkVi9KG0MiIBpVBpuPEJo@vger.kernel.org
X-Gm-Message-State: AOJu0Yyip2GYhmnMnDcRcrhOHF69oKNbtKMaCzy+6LS/Bt4Y3thovrVQ
	k5xF7nNqL2OOw8tTMu45IkHPc8FKHcrdhlkPxbjNO6iozoJd0RaWvr4k
X-Gm-Gg: ASbGncuXF5U3uen3/gUfP+TSf1/d46APYK8OQ0HXlt0WwCwPvpNVUqp2/O1oUVqXv00
	1xtcvXXLgSMDDNbvjN5bi0H+d9cXVbnCg1rO91NIovh3jZHpIJIPrAjDr+mrENvOCSUTMjZAAwu
	Ac1rABB3rjSXGOa2pZyQTHmcz++1Kngx1E6HPxJkgN8phuhETgvOv7W5epb+UzO4UQARtJocSjb
	98zh49O2LfCUpD9HMbJA0KXuPtbjPt42YQgh8zSbPb+yUVuCvh/gF7OiPF2weCGdb3GJmVn5H/K
	Jg1su7YJ4O+P2gsLnHzQ3IsGHid6J9x2goyOSd6ZaNFrukPJFvVQL2vfiZGvi+18MhnNFcFqg2D
	E9bz3k2qBGW5HFHWaQ8Bifl+OtrvBm4hZMwucLUMMFE4DBviAZEAW+61hkRzaYgUWbw2O2+o=
X-Google-Smtp-Source: AGHT+IEQrU5uwPDP3B0D60MQHHmGXSAeXE5fv7FgIePf1xPikPaNbxxiXR2fp/Zl+qVssNoTrpyjFQ==
X-Received: by 2002:a17:90b:3843:b0:330:7a32:3290 with SMTP id 98e67ed59e1d1-343fa751ad3mr18844371a91.37.1763487075532;
        Tue, 18 Nov 2025 09:31:15 -0800 (PST)
Received: from dw-tp ([49.207.232.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345af0fcc0csm1694884a91.0.2025.11.18.09.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 09:31:13 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Christian Brauner <brauner@kernel.org>, djwong@kernel.org, john.g.garry@oracle.com, tytso@mit.edu, dchinner@redhat.com, hch@lst.de, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz, nilay@linux.ibm.com, martin.petersen@oracle.com, rostedt@goodmis.org, axboe@kernel.dk, linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/8] mm: Add PG_atomic
In-Reply-To: <aRcrwgxV6cBu2_RH@casper.infradead.org>
Date: Tue, 18 Nov 2025 21:47:42 +0530
Message-ID: <878qg32u3d.ritesh.list@gmail.com>
References: <cover.1762945505.git.ojaswin@linux.ibm.com> <5f0a7c62a3c787f2011ada10abe3826a94f99e17.1762945505.git.ojaswin@linux.ibm.com> <aRSuH82gM-8BzPCU@casper.infradead.org> <87ecq18azq.ritesh.list@gmail.com> <aRcrwgxV6cBu2_RH@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Matthew Wilcox <willy@infradead.org> writes:

> On Fri, Nov 14, 2025 at 10:30:09AM +0530, Ritesh Harjani wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>> 
>> > On Wed, Nov 12, 2025 at 04:36:05PM +0530, Ojaswin Mujoo wrote:
>> >> From: John Garry <john.g.garry@oracle.com>
>> >> 
>> >> Add page flag PG_atomic, meaning that a folio needs to be written back
>> >> atomically. This will be used by for handling RWF_ATOMIC buffered IO
>> >> in upcoming patches.
>> >
>> > Page flags are a precious resource.  I'm not thrilled about allocating one
>> > to this rather niche usecase.  Wouldn't this be more aptly a flag on the
>> > address_space rather than the folio?  ie if we're doing this kind of write
>> > to a file, aren't most/all of the writes to the file going to be atomic?
>> 
>> As of today the atomic writes functionality works on the per-write
>> basis (given it's a per-write characteristic). 
>> 
>> So, we can have two types of dirty folios sitting in the page cache of
>> an inode. Ones which were done using atomic buffered I/O flag
>> (RWF_ATOMIC) and the other ones which were non-atomic writes. Hence a
>> need of a folio flag to distinguish between the two writes.
>
> I know, but is this useful?  AFAIK, the files where Postgres wants to
> use this functionality are the log files, and all writes to the log
> files will want to use the atomic functionality.  What's the usecase
> for "I want to mix atomic and non-atomic buffered writes to this file"?

Actually this goes back to the design of how we added support of atomic
writes during DIO. So during the initial design phase we decided that
this need not be a per-inode attribute or an open flag, but this is a
per write I/O characteristic.

So as per the current design, we don't have any open flag or a
persistent inode attribute which says kernel should permit _only_ atomic
writes I/O to this file. Instead what we support today is DIO atomic
writes using RWF_ATOMIC flag in pwritev2 syscall.

Having said that there can be several policy decision that could still be
discussed e.g. make sure any previous dirty data is flushed to disk when a
buffered atomic write request is made to an inode. 
Maybe that would allow us to just keep a flag at the address space level
because we would never have a mix of atomic and non-atomic page cache
pages.

IMO, I agree that folio flag is a scarce resource, but I guess the
initial goal of this patch series is mainly to discuss the initial
design of the core feature i.e. how buffered atomic writes should look
in Linux kernel. I agree and point taken that we should be careful with
using folio flags, but let's see how the design shapes up maybe? - that
will help us understand whether a folio flag is really required or maybe
an address space flag would do. 

-ritesh

