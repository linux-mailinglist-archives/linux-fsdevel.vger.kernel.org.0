Return-Path: <linux-fsdevel+bounces-46846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD4CA9577B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 22:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8FF3AF12E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 20:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40ACD1F09BF;
	Mon, 21 Apr 2025 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxUzx9FL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122B61E0E13;
	Mon, 21 Apr 2025 20:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745268288; cv=none; b=qJ6hjrIXvnixwtWiosIhAIEFquZRQpjJbj/vCG3TxFWEsnox4MikwwOHzwGFw2OLU+FpidiQqn+OVPawPeVW8bv4a8ezrpCMAfcqoeewb+CtxyObQdE+sZsEniPdhKUewUBYsXDLijcekSM5Lh2F+pvGEtKoqyLq2cvuqSNTJW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745268288; c=relaxed/simple;
	bh=kMQ6dsTyfG63/1kw83tdosfkH43Q5g74jtUJtHKU5iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcpHIgYCVDKXcdJWsPHWO9CY3HbGss3n5Dd62AyM6dGPIOinmyU2zAhBMQ9PF+Z0L3W962EtyWpo/umM5vFuk0UpWx60clkhTgMS0erQNUagBD31TfmUXr835G0DqE7+IiuK76OZU22j8lN2U0ghVpDfDcmqzYbPyfQEW7yPiOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxUzx9FL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so33211605e9.0;
        Mon, 21 Apr 2025 13:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745268285; x=1745873085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oSz/MC6slpl/A+u1WltEA0ZYmXnRfnHeaulWQDxLZ/8=;
        b=LxUzx9FLI8OeO76iEw4BkyvB4wdoAx7Z9LnFWUynK/cPhKxhiR0tdmvc54XGfTmEH2
         Bu9rrjx0Q5EEP5UJXmgsqqA1TsbGpZgw56iyvDU7j/ix7ty8/CuNMRfA/6B4mIQE0RGq
         dFZALyExuU+pvWeCJMHj55L7eQDCgikmYT02Xftmh203LA8LCzs8GdzvqNz0hZ4L/nvY
         KLRqh78SUcE8WPdif6JM1C84VeFlYM7NXjUnIdvLMDmOK+v1Ccj+KmE+GJUZF2u16Cux
         NOMabLk96csWtdlcR0R5F7PJQJeHrxzl1zU+HdTt6VvenO5x8jviW+PPBlzNcvzkaCcc
         4xAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745268285; x=1745873085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSz/MC6slpl/A+u1WltEA0ZYmXnRfnHeaulWQDxLZ/8=;
        b=TiQmbigvLkfa0aV150x7rT0sfkgo0oPU0VGMKH/cspYE0KBM6Aqt8VD8fQAea8zcna
         ocGJuUBmNNiG4POFcb4LDGt1r5yyMQ/Shd/npblGP34H7pRZQUQOSKkA2vToGMKklQlb
         VxILGazTKFOFx2xIrho6uQX+xxr0z14t50P1eB5oJ4apwnG0DeIOOLtRNYETlEXvrEuW
         joWkO1cvKLvOMRdWzWeLyv+u4hoEpoYuy8TUujhOPM1k2erjiab5hnfpbeDaFCJTOybk
         vybVHmvsStSpEP4zC98eUN6pQ33U0dcERzO6ZQAMHJEDnUJjoPrnEJXOg/1rDuVylVw9
         aIaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0rdRRI/DOIROZtt6DPicSprDQoZxl2f26ItUIYh1J0SybofeK187SvSBZt+Mqiw7U0Qu7x3gosP+Vahbe@vger.kernel.org, AJvYcCWY0dFvOHbU5l0682OJrxEqz8bJgR42sw4TnnKmEuirD9XxHfiIdBdA0xA952hG7+GSCiwa6G3O6FOS@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc4CLZy+m8HJLCnjH0RFmDEAh3VMu3AiQ0+Dvobb6PRSmSEjlM
	Uq48sfqSIby3ziIdndbn3xf58TXn1iI4hA8BjzsuS7XrTvzfpe88
X-Gm-Gg: ASbGncsP9SxpC3MKLVxoYc7zvgUit+YkCKrU4tDGGi3SBmOR88eE9uvtzexbA2sTH9Y
	tekVi3Y6gUVBw5sSZYu7tX1YWeqzf3ENpN6kZu+q2JkJxEqsap2ILjO1fciYpxfZzB1pSJFKniv
	4FIiz+qPgebgXZ6Fa48c1l3NmE8LSygHUoVXKhkL68DKqdod0ZXqJU3YfcbwzofFYt1AwpUwKLB
	rGi0X31J1OXxE6rleoejzGhgriWdV9NRlyh7xc2+UrCs8S5mVJa8lfEN5lMxZ7gDlNaC7CrARbW
	prwZLVUtiZSq4N5sZ6QvnBC6d0F/xOOWyHBcc2FUEHZB6j1IAouf9DyKLY4bwIhQQQs=
X-Google-Smtp-Source: AGHT+IGuWkl7cZpOblBye3lMN7O68Fq0TMY9ZaI3Gy73kE4Wcbx+v+Tq6ZPPw5firbylT1/0IW0Khg==
X-Received: by 2002:a05:6000:2512:b0:39a:ca04:3dff with SMTP id ffacd0b85a97d-39efbad554fmr10156968f8f.40.1745268285114;
        Mon, 21 Apr 2025 13:44:45 -0700 (PDT)
Received: from f (cst-prg-93-196.cust.vodafone.cz. [46.135.93.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4931c3sm12795268f8f.77.2025.04.21.13.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 13:44:44 -0700 (PDT)
Date: Mon, 21 Apr 2025 22:44:38 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: {FD,O,...}_CLOFORK have been added by POSIX.1-2024
Message-ID: <4taakq3b6l6lr26qg4rhj6whwkzrgxv77cxgqeoj2edmuot4u6@5yxesrgwzhsp>
References: <e2t4obcqeflajygu365ktxnsha5okemawuwl32mximp5ovdo53@2pq2f46wfdkg>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2t4obcqeflajygu365ktxnsha5okemawuwl32mximp5ovdo53@2pq2f46wfdkg>

On Mon, Apr 21, 2025 at 10:21:26PM +0200, Alejandro Colomar wrote:
> Hi Jeff, Chuck,
> 
> I'm updating the Linux man-pages for POSIX.1-2024, and I noticed that
> POSIX.1-2024 has added *_CLOFORK flags (with the obvious behavior).
> This is just to let you know about it, and also ask if there's any work
> in adding these flags.  I'll note something about the existence of
> these flags, and that they're unsupported by Linux, at least for now.
> Is that okay?
> 

There was an attempt to add them and the idea itself got NAKed, for
example:

https://lore.kernel.org/all/20200515160342.GE23230@ZenIV.linux.org.uk/

