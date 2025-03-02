Return-Path: <linux-fsdevel+bounces-42893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A6DA4B103
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 11:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5DE1687F5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 10:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34F11DE2BD;
	Sun,  2 Mar 2025 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R6N7zKvZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757E61D5141
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Mar 2025 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740912925; cv=none; b=skZGJ6QqYKmOUmlXZlHC6+MD4d6friKvhLjPCm6+k8AtHRsBaXHsx88nsvKpdlhoL6vtiiJEa+oNISfPNt25yu1vAYZmsX4n6FdoELI6JCeY/71BdBvutL3xdHlQYkMjfDShxnrGheY7uIPOxNZ0lsdXWKZzFpAHA++l0KqzmZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740912925; c=relaxed/simple;
	bh=YP9vFesE7FOkWTsjQeuOzqlZhTxpNdth3TwzKIctpts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBGtFXpqpcH2BM+JOc/143GBMDMikPbSFSs4d/CPyyhRf89XT2OuvmnYzg3kVxgNxH2ejRb576JATyb0O4rnN/yxY3YiK0x/jW5Ara96X+r9oEHkmeXI7wVTjo5NWZb6aNQ+41QJDANv4CYlUlI5doN8HRe5Xm8rdhmjeexYp2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R6N7zKvZ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e058ca6806so5619505a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Mar 2025 02:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740912922; x=1741517722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yVNL0sPyTN/JB4JKueVcudW2dTNqPhTdzuxyAD7JqBI=;
        b=R6N7zKvZlE4/rgMWk99r/RYVwzFGfaGvUj77eiGcWjZoOzFAuueP2cfE5xY1IG7z0R
         gYlZJS/HNggi0AxfmCxDIZ3yGHszRp/hCiQiqYNTL8GqLOOADzP9MI95+8dqUJphUuzO
         wHEAoxz8IVEHv/MCzXNdqsDagD+yYlfKjfHzGSZ3o8TcPdIzscqzmJKssuVt/xO7mC7J
         qUAWz+BvqMiQuaM1tTag/JcOmTrX1ZEkSjoweaQ+BGW/mOwVMrDWbxAjsQzj7ePn64t4
         6oTfZqh4hiy5e79XN5QQJmQsX0a6Xc5yu1Ae05zzvx7CzEzDAJ5O4HqBsHsXAQpfLhI9
         lv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740912922; x=1741517722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVNL0sPyTN/JB4JKueVcudW2dTNqPhTdzuxyAD7JqBI=;
        b=Dy/eY2AEutbB9O6JpNn+giCTk1sLHKmCXCR+F8mtYj7roBsJz1YcuF6i21poD5BYe2
         6E8Ar98vkHuZ4z8Wqh9/SdsbmoFTAsBPv+37JbGCLdiB0TMVf1+4l8v4IECUIzx0vg16
         QJTjj9oIsyGD1jEMnHJjsN2W30r69zVz2WV9LQG3vR3pyW68JQPIUZFFhzhkuVhft1o2
         5JX4FVcEyt9fZe2swypdfLQH1YIqEd9RcQ7adT7/KF3uM0fn6sOvqMmd31T/jwCjoPAt
         daIp/5kje/SHOfWiGa9Yb1UrtkBR4Fd/WAjj423/YnHqvgOekpFOjem4a6dlJZ/EU4+y
         rnzA==
X-Forwarded-Encrypted: i=1; AJvYcCV1lCZoqRRSI8I5T9E8aTy4bPjNa3M9TGCcc8VkLtbbvgiBPVtHAxfraN3jwAphsltQqKmgY3zN06807JFV@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd6XGyuUp68eRt+xoguDl/rufzzY1Jb9QwbBKx//wITEaqnn3X
	NYbEsgDsDgCn6ifeWkNwH8d6h6qaS+RiSP3ZTXwAzkJBtMcU1oovR1S3BWp6AZeAR6fyh+KwgkQ
	J
X-Gm-Gg: ASbGncsVaT1539bNTVcBil1gmYi5voxnfhcKAfhUcZLYDg4OZc//3+Z94N49OboD6zc
	dCC+CoOaaK3X9oY9OWi0wPT/6WBK5SUF3ZPFQwicp9HUYAOVrIq3DVQSUOf8fi3KzqZjURwzTrb
	6jIdfwIo+5GqYPAsOg9siIQNSkaM3PZ8ShK2ebeyLf9CJRGow4DOv5LowqyOxiYkT3PFAP2wQaE
	GL1WqV0xraIudfDRyKW9strt7DoQEdRrsCCpBRWw4a4u2/aEIlT7nmDGafOl3V7rl4RQidd+Xib
	JTkIpDyR9wGIH6wIovroYHspsMfDf3H6K2NVry4nhbUpu+32Kw==
X-Google-Smtp-Source: AGHT+IF5u6hOznuueVO45DvOr3tnpJV+3iyHP7nKiHIBEz75iKNJU9mKeQvZWjwJzKMqMC7qM6j60Q==
X-Received: by 2002:a05:6402:3512:b0:5e4:d13b:e65 with SMTP id 4fb4d7f45d1cf-5e4d6af15damr10563438a12.9.1740912921716;
        Sun, 02 Mar 2025 02:55:21 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5e4c3b4aa46sm5309846a12.1.2025.03.02.02.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 02:55:21 -0800 (PST)
Date: Sun, 2 Mar 2025 13:55:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-staging@lists.linux.dev, asahi@lists.linux.dev
Subject: Re: [RFC] apfs: thoughts on upstreaming an out-of-tree module
Message-ID: <b9c2ce02-dab6-4b4d-b8ca-ac1e7769e0c3@stanley.mountain>
References: <rxefeexzo2lol3qph7xo5tgnykp5c6wcepqewrze6cqfk22leu@wwkiu7yzkpvp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rxefeexzo2lol3qph7xo5tgnykp5c6wcepqewrze6cqfk22leu@wwkiu7yzkpvp>

If you're going to do a major re-work it might be easier to do that first
before you upstream it.  Once it's in the kernel then you have to follow
all the rules like breaking your commits up into reviewable patches and
not breaking git bisect.  The rules are good for quality control but they
can be burdensome for people who want to move fast and break things.

regards,
dan carpenter


