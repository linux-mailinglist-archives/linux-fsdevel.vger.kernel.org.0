Return-Path: <linux-fsdevel+bounces-68176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B5AC55DD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 06:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 046704E31E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 05:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003D33081AC;
	Thu, 13 Nov 2025 05:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2VYgd/g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF0E2AD1F
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 05:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763013239; cv=none; b=o0iT9I/gQI7GyfaQxyFvNUA1Gyv4HD7LKMsAf2TtQ87+NmBq/YHG0C/GFt6ak2Oe1UzjDJrHVAuSApga2FKDNUmO/lTCV1mNclPB6oxHLgnrqLsEFXtYPLXdqYIx3cUcVEdMgMtQ6SOXRzC1rIlW1OZ2wMptgc9+IqgaWuCfpk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763013239; c=relaxed/simple;
	bh=G5i5DL7xw9uVAkYcjg+MHuhn04UdAZgfzYJ3MKANfAw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=CasPIxGt0/jXFPHUqmxUENcuz0ViTmXuQoKjP5IsslV+3pbvK5CsM2Z9QJyZiEkRLTKIDobI9zFp9EUTXrdSdMp5fwNYyWpgsX27FxlLNQuhfNNA2pxhH6SvQCD5nuyROAqCDNjKr358ygQbR6Sbb09Efktlx4nUQfv4rZHhIdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2VYgd/g; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b6dd81e2d4so389763b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 21:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763013237; x=1763618037; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2UyP0ogKxI9Y1Qsu6mcA+/ZagVf5oyFn5jJYg/5sVy4=;
        b=R2VYgd/gSHShdVYxRp1tmwr1qySTws7MYLV3MWarXUOXzL3OIEjH8caB0NQOWdPYZD
         rI3PEDELbZyWeK8hNOoaFsXuipZ7cUygFQhnburJc/0kXmYkgHkTGng8bR8SBHOCJj4E
         53fFaNXd2UkmKbycleogi0lqdBIGUfboc0LRIWEsaZ9Oh0wvWlt8hscCEmIncrfv1W0c
         kZCvsqDmdF9hsYo9Ktk8Hrozc8ik0cPhfTAYrszTmXMWzfB+v9LtAeLW9mh5wbGMVKe+
         RhWd8Gl2Gs+A3e0gB5cLb9fUP77n32C7fyxbKmkblnInmAdmF4ZwCtQs09PbiAaYjm/G
         KNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763013237; x=1763618037;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2UyP0ogKxI9Y1Qsu6mcA+/ZagVf5oyFn5jJYg/5sVy4=;
        b=bRVM5voiyMY8qOJmH6aaSA8IWEHKxnJkLjps/wSSL6i0Witi+M37XCuqL6QWWfQNB7
         3LD4H/qGOy31eo9aMsS7iRiMUBv+eigcvtUgM4NpUDp3iVM5KdNAv+33gOMnxYdl+NJL
         zaEXW90FfATPzFEWOxGgkQV6OoP4xIo/ub+zAR9sO234ff5C9PWy5RnwMPKCQvZMOOdE
         lQsvf6KmE5JcJuI2G3sELEaUfyLW8hRIf01FVfFr6bf8Hm9bUKodkECjN2IO4hKub5uQ
         xFbEkeWKwDT3GI48MtAyQqN/twS1p2Ql2GJVKxVmZgmlb1DIJOSifqrycY3VHvoIbHUt
         2zFg==
X-Forwarded-Encrypted: i=1; AJvYcCVAuKrB6QzJZLk0E0/6zajdxgS8n7DEUKBNy34ndGpZDrMAbrlT9T1WPlG+K4zEcTjMOsM7jGODv0HLPRJe@vger.kernel.org
X-Gm-Message-State: AOJu0YyPLYZN//K1ytgxUCGXtBTs/lbMVchJTFn54q88vMHGkD8mCsgf
	6TYckTocYkmGbuYN9AyxLPoNIo27Wam8GksUy6rd15p9eetrcYXreHSn
X-Gm-Gg: ASbGnctkg82ItxjClIT4o960OV9AUc7Bjz8K53Goau36EBC2tyuL6EWlN+PhW+b6c8T
	2P4JKTOy3HdjO6SZzU6H18swQfYNCz5Yv/IZaWgNZ+R8GElY18XHlnRO1zsUoMwLJr3X8yNgqv9
	31xFcAo3OAW43L2O6Vjx+9dnEXOBWnBURllmUrzBE8CT/xr1eWcsnIiZ9+C33FAwp8sNrkFewE1
	OAtyJDrgBYR1LL+dB70MrvBa9OUyernpaJ3iY56FdDH+4R7fU/AKMKWx75fIk6UgIzFK3HDhtRM
	pEAg9nDw1quKmlpzo/FTmLXbLp0SZVQSETnXYDxa/hFLmF6yBal0pF89wMIRB1fJlVEJ58AAen8
	8v23thNOuGgnfLseR6MLrIUXgxTC3nAltDbKeuyENgp0ho3QvZgCQM0GFdpGnL8VzHLXJ5K0=
X-Google-Smtp-Source: AGHT+IFlsnZ0k8muJSrddDRx8GFRERSbeF4nDY6yspGg9WIg4wg50amrL5Z1QtXjRUhp3wNQXmZujQ==
X-Received: by 2002:a05:6a20:3d89:b0:2ef:1d19:3d3 with SMTP id adf61e73a8af0-3590968f3ffmr7213716637.14.1763013237233;
        Wed, 12 Nov 2025 21:53:57 -0800 (PST)
Received: from dw-tp ([49.207.219.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc365da0191sm937384a12.0.2025.11.12.21.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 21:53:56 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Christian Brauner <brauner@kernel.org>, djwong@kernel.org, john.g.garry@oracle.com, tytso@mit.edu, willy@infradead.org, dchinner@redhat.com, hch@lst.de, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz, nilay@linux.ibm.com, martin.petersen@oracle.com, rostedt@goodmis.org, axboe@kernel.dk, linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] xfs: single block atomic writes for buffered IO
In-Reply-To: <20251113052337.GA28533@lst.de>
Date: Thu, 13 Nov 2025 11:12:49 +0530
Message-ID: <87frai8p46.ritesh.list@gmail.com>
References: <cover.1762945505.git.ojaswin@linux.ibm.com> <aRUCqA_UpRftbgce@dread.disaster.area> <20251113052337.GA28533@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> On Thu, Nov 13, 2025 at 08:56:56AM +1100, Dave Chinner wrote:
>> On Wed, Nov 12, 2025 at 04:36:03PM +0530, Ojaswin Mujoo wrote:
>> > This patch adds support to perform single block RWF_ATOMIC writes for
>> > iomap xfs buffered IO. This builds upon the inital RFC shared by John
>> > Garry last year [1]. Most of the details are present in the respective 
>> > commit messages but I'd mention some of the design points below:
>> 
>> What is the use case for this functionality? i.e. what is the
>> reason for adding all this complexity?
>
> Seconded.  The atomic code has a lot of complexity, and further mixing
> it with buffered I/O makes this even worse.  We'd need a really important
> use case to even consider it.

I agree this should have been in the cover letter itself. 

I believe the reason for adding this functionality was also discussed at
LSFMM too...  

For e.g. https://lwn.net/Articles/974578/ goes in depth and talks about
Postgres folks looking for this, since PostgreSQL databases uses
buffered I/O for their database writes.

-ritesh

