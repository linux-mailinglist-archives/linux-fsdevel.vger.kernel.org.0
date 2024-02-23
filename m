Return-Path: <linux-fsdevel+bounces-12569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FF6861294
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 14:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7825928659F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 13:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CB67E579;
	Fri, 23 Feb 2024 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/3AiaNV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7F67C6D4
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 13:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694638; cv=none; b=OC+CmUFfpdnqsoNnIEr5K2nHbjSwD+rYrZ00qJxCKXY3AH48qcMiLckijjYq6qGHvzBKIv3n+PFd6EhsqS3y1YExpNrFaK5boZ3sLLNBSoEVS/JRpcMGWlVtXeaqgsqvxRRQXfpfT05oZN0fIJjdPnyQZneGGN2XqgelPNLo/Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694638; c=relaxed/simple;
	bh=6e0O4DMzFkHvn7pXNTJf65SMbBZkdyOQG4/zKdeHt/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9Zs9vDDTlCWLmoqP/pFI+DgOWRTedcP65MjWU9ql+7Yz+aZtwM4vJomTsCzTcKp++3AsdnuO0a0+rWFjkXttJ/L7itIcHea/JVONm+zxKELp5MVsmIYraMco6zi2C9Pf6AjFuZL5OxbD0er2LLOUU9tcbighzSLL8yEkwgOWBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O/3AiaNV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708694636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hqt7S1NoHacsgWuh60F4sxJhipun6fhVaSw2FUE+AfQ=;
	b=O/3AiaNVnkzaUz7CPQW6rEVvqJ5Tmew8q5Vga8MI+sS23Qxf60sNkh5LJOS7kh3oVmvPmz
	SqBa49aZy3cvIajIOzPcmiFR6CLxbILg+z4Z1GtQRH0Oxtm6U2LSbGgrRKRTV8ngG6zY4h
	KzziJeqRWhbQU1nH9/zwfP2xdHYY6Ss=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-y-NQeFJNMvms6txv9c_LFw-1; Fri, 23 Feb 2024 08:23:54 -0500
X-MC-Unique: y-NQeFJNMvms6txv9c_LFw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33d6fe52221so150767f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 05:23:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708694633; x=1709299433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqt7S1NoHacsgWuh60F4sxJhipun6fhVaSw2FUE+AfQ=;
        b=UA+8E6ga2+WmO/kKsYFhDFBUSOMxCqiz2PKpI3fTmWLa19LFkY7f20OoiadQXBrH7I
         qc6dlAd5NWKZVI198mhhk4Ewx0iZltaMj0LKarwLhoGPM9925hPj9wtHfigxorkKLE9j
         Q37nrvTRtVsgET1QcXIEG6OTYUtv1XVXD9IdI3ognDAnA8I7+G9bRI+6cs+A2JwRpJjp
         6byWNkJJ+hnAER6YLMvhZJ/li7jdRaBakUZ3ORJCEbqTSnXNqsgWdP8LxbKsVWP9LjoB
         BYClL/X0DTMjtyqgEe4QUj6fDDh7AAIYhM1A3iuIM+7fmifM8LIqla4Fc2PRTP+vH+/c
         0k+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUW0c27EAdjfc2DV6D66OSKjknXSefIuncyJC2c5YtTeK/SVLmwfOWMswVb94v+ZcmzP8wAtPnd2oD3NXVuUyv2OihRyxbs/3KUEuXccQ==
X-Gm-Message-State: AOJu0YwOPqLwN9vGMvpmYipoQjH47ungyn3V+aQ+/iaObVguGPKbaxmf
	0kvF5JjqN+g/Xobl96ZMgyRpsSXU+HAQcf+11AD6ExSZEjSL0vBs9uQ9zK2d8TWfXGT2WvbyZ8l
	UrAFPBQ6hKeK74SgXyp7pJOjLp66NTxs0EuIgakq3JajHnHSlZ8O2wdYbuh14hg==
X-Received: by 2002:adf:eac3:0:b0:33d:7eb:1a6a with SMTP id o3-20020adfeac3000000b0033d07eb1a6amr1294413wrn.68.1708694633704;
        Fri, 23 Feb 2024 05:23:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcPXl8fo1bQL43nBgcdbRjOKnZSJ455k+RrAoRssBnbauM8/hwRjxl2I7+BEiwDHQq9Z7L/Q==
X-Received: by 2002:adf:eac3:0:b0:33d:7eb:1a6a with SMTP id o3-20020adfeac3000000b0033d07eb1a6amr1294402wrn.68.1708694633392;
        Fri, 23 Feb 2024 05:23:53 -0800 (PST)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id l7-20020a5d4bc7000000b0033afc81fc00sm2737566wrt.41.2024.02.23.05.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 05:23:53 -0800 (PST)
Date: Fri, 23 Feb 2024 14:23:52 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com, djwong@kernel.org
Subject: Re: [PATCH v4 09/25] fsverity: add tracepoints
Message-ID: <copvwl7uhxj7iqlms2tv6shk4ky7lce54jqugg7uiuxgbv34am@3x6pelescjlb>
References: <20240212165821.1901300-1-aalbersh@redhat.com>
 <20240212165821.1901300-10-aalbersh@redhat.com>
 <20240223053156.GE25631@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223053156.GE25631@sol.localdomain>

On 2024-02-22 21:31:56, Eric Biggers wrote:
> On Mon, Feb 12, 2024 at 05:58:06PM +0100, Andrey Albershteyn wrote:
> > fs-verity previously had debug printk but it was removed. This patch
> > adds trace points to the same places where printk were used (with a
> > few additional ones).
> 
> Are all of these actually useful?  There's a maintenance cost to adding all of
> these.
> 

Well, they were useful for me while testing/working on this
patchset. Especially combining -e xfs -e fsverity was quite good for
checking correctness and debugging with xfstests tests. They're
probably could be handy if something breaks.

Or you mean if each of them is useful? The ones which I added to
signature verification probably aren't as useful as other; my
intention adding them was to also cover these code paths.

-- 
- Andrey


