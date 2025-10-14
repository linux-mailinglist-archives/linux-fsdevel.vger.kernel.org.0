Return-Path: <linux-fsdevel+bounces-64105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE39EBD8AFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 12:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E39A3524C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 10:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB302FCBED;
	Tue, 14 Oct 2025 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="d85UoATp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD1F1E990E
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436831; cv=none; b=RxYV/wWdPCOmKTWWVA+0UJ1PBukpKG2O3FVzJKDKni/YMV9jeehcwMRnmnmGI1+HpPSTlsRM/phRC31ulsyq+KyvN/MHEb8ZD4f6cNJcTudJ8oSK+JFOGEdPoFKSpLyu98C0WnXyBVxmeWdTdKC9pVnMYwY/S/LNgJeZuvWmZCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436831; c=relaxed/simple;
	bh=Eh5BVoIdj3E+g/qo7JJOEx2ayp6tBh/70JNpJI0OD+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcJ/9/F7o97gDSV/6/otUpfnWFc7l0Ol260gFEGtosngosCXZKtm8e2ONThWT1CAUNz1o23igW1fD8kXQrY6Tr25S6GspWjy0qqZwh0WjBH33ADfo4nu+eKlrGES9e4boXy3714CkdisV9LN9yATeJvMs1vnTavdW7T/xRIKx8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=d85UoATp; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ee15505cdeso4318261f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 03:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1760436829; x=1761041629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MszmfM3qK8hojDktVnhjA9AYopNSPQh34JsmCIb7qSc=;
        b=d85UoATp6fQGf77g72ufnB+c5XzyTEdYJpJ14ctGTEu/Sahws0rO3IgWEUJcWak6xM
         euwiPhvxcZ3gOWW3NLlzMZ+FnnpDl9BsItmr5CXTDFwibSpW3awPUFodQZMSoiyXS5LU
         tV9xx9GKK7lOayJSDblSwVye7gWNCEvq2XpYlmaWjQ/hYr+iD2113aTwn5qxygvYjV/S
         XDl4NUTgUkLu/9/BSQCHk/WP2hs6z+s6vcSi0pzL6eW6NiSgZyw+uJg6IeGvyNSlndGA
         WQPX2Ui+es4PLgUPGrIhx8B43nzbNPZEkhts4ipWPU4FnLgrdOUAKBX99Aiy8QGCaKkR
         NP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760436829; x=1761041629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MszmfM3qK8hojDktVnhjA9AYopNSPQh34JsmCIb7qSc=;
        b=dTxUL0X8UDeJlWdoAmsCKDjl1rUYVVQ9k+QvAm8Nmn/cBQy72eer+nfJ6h/TtGfuMT
         jvG265Trby1GXg/TRlEygN09Nc7cZHDrISU7Tv13wki06sQjL+EmKZ9coN4f5sEx/Zhi
         bIBnhpokoO+y/Dy181QA/DQOVvfhmRCvo1bKye5AZvpE1rCiIgwQeK0GZ4jlfleyyr6A
         MY1lBgJ2v5npgwG6RImvB4Ijcnky/5AnmIiACkQCHQPvVM+PvAXjKZcwTmv8uftQjy8O
         N4BJVYDZJzjFmovZ08MNdLY5d3SmZgxnDlPhq2SPwfkTawPlw1oTlw6AOX5qiWsjeaX+
         ZaQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX31dPmV7ubWniIDv1A3q7VAeY8INH+8PKU6p8oUVnwwEfQHMn5voF61I7iSkZXXIZ7eR3kKHOIx9pIf4M4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz524s2hYr1SJiuXC6fW9lBrGVOTuELfYgXk3Q5j9YdPl8MExpB
	ZyxSIwFiiMlK0hs9PcROnstPXoqE+6hiLkal+UV0+1z4pGYxsEvmYlCm+NcMVXHOgd3Nh0QeZgT
	he2fIxUw=
X-Gm-Gg: ASbGncsKuKBQ1uaz7OyeMF9q9HFdMRKKYV1tP3eXqs7IGZqFRo1ecceQ/G5pchYbRkS
	PrnXUfqOdprw1eG7dLjXluJ62Ds6Bs8KsPiwwe9fyU2jepbDvLJG5BGFbu6qlJG6woLZjSYqRm7
	5EcastpqWJn3Nw9v+N9bkANXajRzpcQBqUprreK54OSag+RFrgezc7I80qOFnS1xY3UVgqvWdJg
	tsCb9wTsOoMAsZra5DDXPrBShJWxmopiXVBebCUf6h7FIRDMybhzx5liIvbCRL90v9wCqbIg4h0
	R5LEG6j/8MXosaLeJItRKxy7h6nnWYQu3A0Vf9gMXG0uPvWIHbs2X0hxcHhdOrQhI+SjF/iFJKB
	wXQfyOhDtwOFWCvdBDqdMcpE+pw==
X-Google-Smtp-Source: AGHT+IFWdFmuBH45KApzDATfMiXATkGI8VwBnZcXpUsUtaPvnVOQgNZ6Tnlsi5kbUQn142h2b+DYoA==
X-Received: by 2002:a05:6000:4009:b0:425:86d1:bcc7 with SMTP id ffacd0b85a97d-42586d1c0cdmr15589331f8f.23.1760436828649;
        Tue, 14 Oct 2025 03:13:48 -0700 (PDT)
Received: from localhost ([2a09:bac1:2880:f0::3df:19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe69sm23371423f8f.32.2025.10.14.03.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:13:47 -0700 (PDT)
Date: Tue, 14 Oct 2025 11:13:46 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Jan Kara <jack@suse.cz>
Cc: adilger.kernel@dilger.ca, kernel-team@cloudflare.com,
	libaokun1@huawei.com, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, willy@infradead.org
Subject: Re: ext4 writeback performance issue in 6.12
Message-ID: <20251014101346.ep73uuigr25xu5a2@matt-Precision-5490>
References: <20251006115615.2289526-1-matt@readmodwrite.com>
 <20251008150705.4090434-1-matt@readmodwrite.com>
 <2nuegl4wtmu3lkprcomfeluii77ofrmkn4ukvbx2gesnqlsflk@yx466sbd7bni>
 <20251009101748.529277-1-matt@readmodwrite.com>
 <ytvfwystemt45b32upwcwdtpl4l32ym6qtclll55kyyllayqsh@g4kakuary2qw>
 <20251009172153.kx72mao26tc7v2yu@matt-Precision-5490>
 <ok5xj3zppjeg7n6ltuv4gnd5bj5adyd6w5pbvaaaenz7oyb2sz@653qwjse63x7>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ok5xj3zppjeg7n6ltuv4gnd5bj5adyd6w5pbvaaaenz7oyb2sz@653qwjse63x7>

On Fri, Oct 10, 2025 at 07:23:54PM +0200, Jan Kara wrote:
> 
> Maybe I misunderstood what you wrote about your profiles but you wrote that
> we were spending about 4% of CPU time in the block allocation code. Even if
> we get that close to 0%, you'd still gain only 4%. Or am I misunderstanding
> something?

Ah, I see. Yeah that's true but that's 4% of CPU cycles that could be
put to better use elsehwere :D

