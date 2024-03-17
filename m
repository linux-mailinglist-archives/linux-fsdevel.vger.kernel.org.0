Return-Path: <linux-fsdevel+bounces-14655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5762287DFE6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 21:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D2E281308
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 20:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8061EF1E;
	Sun, 17 Mar 2024 20:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="bSxkamGO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B151208A4
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 20:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710705795; cv=none; b=RjeprXTBv6YI2GOiUeTesynMJA4dzrP+Imxr0tPg0I2txE+JY+Uk1FqGy0NFQy4nrbRZyi57ienvf+4E5bC7GpUklG3zkPXnUOo6gWRY9HhRKaj4eBx3PqpCrx+eNGOt94FzBi0Ki2AQ90DnHAASx2+jo0ko5nXQ8u8shXXcj3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710705795; c=relaxed/simple;
	bh=ZCz3hEvQDg0TkX0x1Q98DdNlLHSDKDjk6jJaWL/3VPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNhIpbhZabsfhPfIfiv3Ht9XTcnlofE31mSvw15wwEapnKg/3ve2JojtwKUkN/DuOQAV1Z+MOXsCkOt5d/6StIBFqU1hdR4i8s0IYSkTvclBwYFn36t1GLoyHjMc5WrG2yPDLUI5c7fhN7z03Gj8K/fqaK2xQIPKprVvNby1LsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=bSxkamGO; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513d717269fso3420274e87.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 13:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1710705791; x=1711310591; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eP2YbC9+vSvMtu++LBNxCaZfO4vobjbGgrTQ5NDyHYo=;
        b=bSxkamGOasOE/UiUtKZq/ZYoB6qaZY3nvh4UECKOCZi1CdN7jaAuYqKAw0KmiU9n8U
         q6PZhsXlF2HzAsrxgIQ0+dDlXPxDf+03EKM2ugAS4QWk596e5dCtKiQkuypaDjO1XtjP
         cI+rjnKwscN+Rrqb2/dJAM38xkruCQfF7ic2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710705791; x=1711310591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eP2YbC9+vSvMtu++LBNxCaZfO4vobjbGgrTQ5NDyHYo=;
        b=VNWoeo06X9tidFqHrOwNzfFXHXcSkCtwY9rV1J7HHGyTS1LVuqxecwm0JwxXPA2+mx
         1Ey+cV5ds9E8wr1IoCXO7ibDcCwI62JWMnKAUOBpTk0FQtNk0eWr/mo7XnaLpHXfQW9h
         qDcvK+Dfdy0fOpJMnJu0lnT1of/PPjQte68TmWRFSjQQIx8pDXo57+rnJ4TIC7eExfdj
         R8LGBd5XhpeRcPIxGuug6DOIT+ndg6PP1VxY85QE4sccgWzqX2lPdmQStFuzT8/KN4ug
         nNFjLqTxYkvgn3tj9j49sAi3C65vJpgkEyTA6m1ML0cE2RdK+X2d+CkKIvFe/DHTLAJz
         Ks/w==
X-Forwarded-Encrypted: i=1; AJvYcCUeG7NyMo9loYB+NkeaPEAsgCzxZZnCTrjuMQBNH9wh1QMVMs4RIlG1PW/3WpAlOE47VPmXVIoCjqlKJzVE2t0N7Qi84gBJe0fbwnC2PA==
X-Gm-Message-State: AOJu0YzssI/DzOsBgbgJA0S4rpNCc/kAFZuqxpSExuVx0NoD7E+Q5wBC
	aCbllgxIi9ETPRGAuFv8MXrjHNjoMTVdidgRqOB81n7IaUiXYmVSf7MgkOhD0ZWwGbaq8Rc+f+Y
	IGqkAs2dOjHNS+AeTzagdKFGvhDkdEwZyhBmwug==
X-Google-Smtp-Source: AGHT+IFhwgskocY+OqhoQJIW6Er6TrWYI4ZMQ+R6OFNj3IvcdOD5D8IpQfgPp0hZ1gA1Q01Sf5la/wo3NuPgu2Rptc0=
X-Received: by 2002:a19:914b:0:b0:513:d1c7:7d37 with SMTP id
 y11-20020a19914b000000b00513d1c77d37mr5641234lfj.51.1710705791258; Sun, 17
 Mar 2024 13:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208170603.2078871-1-amir73il@gmail.com> <20240208170603.2078871-10-amir73il@gmail.com>
 <CAJfpegtcqPgb6zwHtg7q7vfC4wgo7YPP48O213jzfF+UDqZraw@mail.gmail.com>
 <1be6f498-2d56-4c19-9f93-0678ad76e775@fastmail.fm> <f44c0101-0016-4f82-a02d-0dcfefbf4e96@fastmail.fm>
 <CAOQ4uxi9X=a6mvmXXdrSYX-r5EUdVfRiGW0nwFj2ZZTzHQJ5jw@mail.gmail.com>
 <CAJfpeguKM5MHEyukHv2OE=6hce5Go2ydPMqzTiJ-MjxS0YH=DQ@mail.gmail.com>
 <CAOQ4uxh8+4cwfNj4Mh+=9bkFqAaJXWUpGa-3MP7vwQCo6M_EGw@mail.gmail.com>
 <CAOQ4uxj8Az6VEZ-Ky5gs33gc0N9hjv4XqL6XC_kc+vsVpaBCOg@mail.gmail.com>
 <CAJfpegv9ze_Kk0ZE-EmppfaQWc_U7Sgqg7a0PH2szgRWFBpHig@mail.gmail.com> <CAOQ4uxjrw58f=8-xepx4s9sReAR0WtWQ+Q=B0oKbMZkJPfRftA@mail.gmail.com>
In-Reply-To: <CAOQ4uxjrw58f=8-xepx4s9sReAR0WtWQ+Q=B0oKbMZkJPfRftA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 17 Mar 2024 21:02:59 +0100
Message-ID: <CAJfpegvBapQxqAek5smeAhgLfmSFfkmfGdW_8jBYv+KuduVVzA@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] fuse: allow parallel dio writes with FUSE_DIRECT_IO_ALLOW_MMAP
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 Mar 2024 at 21:00, Amir Goldstein <amir73il@gmail.com> wrote:

> Well, looking ahead to implementing more passthrough ops, I have
> a use case for passthrough of getattr(), so if that will be a possible
> configuration in the future, maybe we won't need to worry about
> the cached values at all?

Yes, if attributes are passed through, then things become simpler.  So
introducing that mode first and seeing if that covers all the use
cases is probably a good first step.

Thanks,
Miklos

