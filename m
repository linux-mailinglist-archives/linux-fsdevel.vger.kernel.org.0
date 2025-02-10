Return-Path: <linux-fsdevel+bounces-41408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CE4A2EF16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 15:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C36601885EC7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 14:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3944F230D28;
	Mon, 10 Feb 2025 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VN6x//Ao"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E673F230D05;
	Mon, 10 Feb 2025 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739196004; cv=none; b=RXtYKF3qx8KOoqZaiB0ohYJxlS+9CHOYDFnq5DnCyBTrYQGtAThuvax4gFHRJAx0zrmL1y7/N6+pqbqYWUdLoCNdWXQSDqVLpUPKdPnDgE/HfZGYJ0LVqejOZ+4pN5IysoSzH907NVcAok8BOQmPpVYRX9mEOeZ5ms8HRPnd4zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739196004; c=relaxed/simple;
	bh=Uxwy4hKp1bY3GwUnF6oPfX3suQJvksR4VgdwJabFpV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJo7SdqDf8di90Xl54A6hqWLKG6LBA5TYUlefuLA27I2y3AMpXTS0N0pvRHQP7LQVUc9ln4bms+qOqD+TWQuKbJhBI1k1i9UPA0f1BfbDZr4tavT9W9emAy/FZC4zKdgKWUYjwoErWjXCD3PHYebZEJ8BksdwdhUVx2zF9nN2Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VN6x//Ao; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab7b7250256so208053766b.0;
        Mon, 10 Feb 2025 06:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739196001; x=1739800801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uxwy4hKp1bY3GwUnF6oPfX3suQJvksR4VgdwJabFpV4=;
        b=VN6x//AoccAAGrI7ETqxEMxOFy4hERtpGZkqLL7cM2pRM0gA++XA10Ze3ZQv9q7zor
         OtxtQC0Ah1uA+ROCcPL04fCqYiuLCY64vTzYskFxthKqjQm7f78PkyZZwo4N5oq6290x
         ATlzmMHotajo3964f9tjPSlO3yuNbafBuISF3facLhefJzSqMTIGL/62zKCkalEpmZCZ
         27X0Pttlq1ESXdDb79MaZiaT/CURbAj7B5urDob6viTZFyFl9Jgi2OE29RlyZ/l8bPg4
         LRcJRXCjcPIBcss4G8fz7WZZ98qIjlJBbwOCgCJNY1vdyH1U1foYybrf77EEbf1mwV52
         5qoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739196001; x=1739800801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uxwy4hKp1bY3GwUnF6oPfX3suQJvksR4VgdwJabFpV4=;
        b=swnTjjiffjUCbUwZTW2kC9JAYIjWMqdRZFifcqBgjy+FKInOsdJHFu+Pq9Fnz5z1V8
         9g6zU9fpXHNmjJCjcq17Pq4OMLYdkXwWtApIFZpllHhPo0rxCWTUnkuKOoclIfDvowR5
         SAp4mgGhsHjJ/xG6/LNyHfyqUnivPwzv5rRgoq3cB9wHOOQs8Ccxe1A43cpYHX46jyD3
         Ku3K3Gl9GRHulv8h72PafVCbfpDhbm5A0ceLsPT5o2WvOq1z6cxwS4Rlsv4hdWQlCWyl
         lEnJYmGwJDudmd+5r/rcE0jthIgC4y5hps8Dkqty/DCPcYm6kbwnrytD00SMqpOUXCt7
         5XhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWABmkKOXMA0JzzBl24gDq2HeLnqJmq59OFpjRNO9NKEbZEAnP9+UfRPyk/PHuzyOAxJhYeP+joDkz6NS39@vger.kernel.org, AJvYcCWNQQjOnd623IUNQ5RJIpmirqy28ZzaGL3kz4705O6Rr9gR5qCPf4Lm5fyYoJrLIT8e+XZnqq6gfFeLu2VI@vger.kernel.org
X-Gm-Message-State: AOJu0YyFiOI9wvlnbe1ke+NQHj5WIFvP6Rs06a67ElCGKAInDVlcIO1z
	VmaYWwdbGkCah4yrJ30RHGYpAxwuW2XvToIs+VlRN/k9P51ohvFh
X-Gm-Gg: ASbGnctdEW+5Tznr9n2B8iBlwbts8Ygr0XFhw2OSVzRz0r8NgqOapDrlAYBbk0ZLbxF
	/4PcgdNVMje7DvtChfQPRU071JNfVn5l80N9z04C0NNjoMVsuKIB2RXA6zjBg1rJUmCf1GcXGk3
	JzrAItIXuLXjJdPNJfC6L33YMV9z7+OaW5SDbD5De2TFJeECGARXk1WHY0VmU1AMA0gS0MPAAbb
	5+KPIQ4XAmkzY4C67+uxnrhqMF3x9NGSVF500Vty5eboC+yOkIRjfQyM0DzBr74RwpXevW8k/u2
	tmz4+TWMVA73Db6WMTPLqiy8t0x/+hk=
X-Google-Smtp-Source: AGHT+IHx+qhU6Idq8jRm0WRWXe7TwvHeKMTg7snP+Bx40IzlGFDOH18fAqC/rTYvXM6eVCNUT6vjuw==
X-Received: by 2002:a17:907:36cc:b0:ab7:9a7a:d37a with SMTP id a640c23a62f3a-ab79a7ad49amr1081195466b.43.1739196001199;
        Mon, 10 Feb 2025 06:00:01 -0800 (PST)
Received: from f (cst-prg-84-201.cust.vodafone.cz. [46.135.84.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7832a02fcsm786876266b.94.2025.02.10.05.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 06:00:00 -0800 (PST)
Date: Mon, 10 Feb 2025 14:59:52 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH next 1/1] fs: Mark get_sigset_argpack() __always_inline
Message-ID: <oo4w7ennuubxt4h4c3p226op77xm74g7rzelpna7ejlfmikjoh@pn2iymeg6flf>
References: <20250208151347.89708-1-david.laight.linux@gmail.com>
 <CAHk-=wicUO4WaEE6b010icQPpq+Gk_ZK5V2hF2iBQe-FqmBc3Q@mail.gmail.com>
 <20250208190600.18075c88@pumpkin>
 <CAHk-=whvmGhOzJJr1LeZ7vdSNt_CE+VJCUJ9FcLe0-Nv8UqgoA@mail.gmail.com>
 <20250208230500.05ad57a5@pumpkin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250208230500.05ad57a5@pumpkin>

On Sat, Feb 08, 2025 at 11:05:00PM +0000, David Laight wrote:
> Defaulting to SMAP just requires a bit of bravery!
> After all (as you said) it ought to get patched out before userspace exists.
> It is still fairly new (Broadwell ix-5xxx).
> I'm sure a lot of people are still running Linux on Sandy bridge cpu.

The Intel folk posting over at https://lore.kernel.org/oe-lkp/ have a
bunch of old yellers they test on (and probably more they can dig up if
needed) and will likely be happy to boot test a patch of the sort, just
explicitly state you want a pre-SMAP CPU.

