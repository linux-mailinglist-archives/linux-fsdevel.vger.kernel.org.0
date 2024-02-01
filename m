Return-Path: <linux-fsdevel+bounces-9825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E56608453DD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75261B21212
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 09:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D8015B11A;
	Thu,  1 Feb 2024 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="QzzTBanL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860B815AADE
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706779696; cv=none; b=RobLtZTCXVXomH7q6Es+wn1d/830KXpV6voCK17uRW+qi5LyAUTXlmE6M6tdV1+0f9JuciQH173+w+/tFVRu1Af/uACAIckVFnjq1nXxS+41xG3Cn2TqwmOlLKDRosGfv1Uv/3Eo5ZQeM2bWKIAZpZo0aDN1iI6aqDfeaOwj4vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706779696; c=relaxed/simple;
	bh=uQpjHn/k8LhRaWfdodt0dBqKXXzAvGqKt+BKjv1aSl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ahk7lAO94uaEmUuoEVlZIizwZj9uXhh22mcrR1La2YHBMqDFqmQUO1dh5N6OZO/ixGb9ds0fQ0ZP8+EnsRq1+Vz+6b1RPH0WrclXtyxmYhF95xVZYA9Z/je5Fh9ffX6UZU1TkE2qq93Inuiq0JQZkq1D0JEzR7Ow+AaEixlcNVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=QzzTBanL; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55fbbfbc0f5so522873a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 01:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1706779693; x=1707384493; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AomKnOYIuoieQS/ihA4cKdwcwSZOo5BeW4PVPnqVgY8=;
        b=QzzTBanL2j4muL+FZPzFGl5A89FAKsUmdsC7uz7zsRJJUdl2r0WMYzkE9fXwepVjNV
         gxXwbmsnp1GgqCTf3j+lcPV0txVL59cnJqmVS36fNoyeTwcoa86ytEnhiplBlt4cJV/G
         ij6T6hNlKIYxex2dPqm4TRR0I1ipONImhEIgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706779693; x=1707384493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AomKnOYIuoieQS/ihA4cKdwcwSZOo5BeW4PVPnqVgY8=;
        b=EM8cm96OdvPA+IqQduqEEV9KYhXrcqOA3FCtT4hAOx6HfIZovixk+LJuRkYjk3mV7I
         zzoeREVN72C/IHz21vAzkwR7X/aNBOckJR+bRTcHJLOLPJsx/QZ6nj93eaVPxV1ECZZi
         DqRjLpZA6TEnSyQ/VV9Bv2GWVTslpHap234Xg8o2YO8T4yOxQk1rWPNSewRaqlpf8O4z
         YLgNalVX4kqW2izk239a28Ffuz00yvZa8pPd3AzXcgO6QsVaE+1hOTjjJMedEdlCnoLQ
         B2JBn+qiKffdxHyrZuXhiCYAaQI/kMhMDkI5ujABRRm8+uuZdkqcS1dH8K5sVKoX19oM
         4dMg==
X-Gm-Message-State: AOJu0YymSqLUYZKTYk5Ye06TXRy5m7z3caYjQecRrZgpIpEAPFheLoyB
	sbfLrL3WerGkqIbGckNgspBfyii8fFSmJN7CaoeyjxTbQu7SjWeUzqR12JHCEJjLudnV31j2yso
	ee/FztnAvAmpNHsHPtF3Lh4CUTMNCk2D5a9jRig==
X-Google-Smtp-Source: AGHT+IEamRgeJz3jGdb2eDDc4tN5r+rp6qV8ZOXHbn3Ij+XsYl9jubtmuM0adIZ95h2nHr6nkj9LK6dgPbqAO0/qnW0=
X-Received: by 2002:a17:906:c12:b0:a36:3cd0:232a with SMTP id
 s18-20020a1709060c1200b00a363cd0232amr5368561ejf.21.1706779692674; Thu, 01
 Feb 2024 01:28:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <VI1PR08MB31011DF4722B9E720A251892827C2@VI1PR08MB3101.eurprd08.prod.outlook.com>
 <CAJfpegvBc+Md51ubYv9iDnST+Xps9P=g51NcWJONKy4fq=O8+Q@mail.gmail.com>
 <VI1PR08MB3101A133BDF889B35F14D28882432@VI1PR08MB3101.eurprd08.prod.outlook.com>
 <CAJfpegup8_Xm7rqbNgbxoZ0+5KnrJiiR05KLO3W4=mmQaRi+qg@mail.gmail.com> <VI1PR08MB3101AA24E1406DBCA133DC7782432@VI1PR08MB3101.eurprd08.prod.outlook.com>
In-Reply-To: <VI1PR08MB3101AA24E1406DBCA133DC7782432@VI1PR08MB3101.eurprd08.prod.outlook.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 1 Feb 2024 10:28:01 +0100
Message-ID: <CAJfpegv+jknMnAAYKnZvemvjqi26X59HRRg7-JhDYVFe4MG93Q@mail.gmail.com>
Subject: Re: [overlay] [fuse] Potential bug with large file support for FUSE
 based lowerdir
To: Lukasz Okraszewski <Lukasz.Okraszewski@arm.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	Matthew Clarkson <Matthew.Clarkson@arm.com>, Brandon Jones <Brandon.Jones@arm.com>, nd <nd@arm.com>, 
	overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 10:24, Lukasz Okraszewski
<Lukasz.Okraszewski@arm.com> wrote:
>
>
> <miklos@szeredi.hu> wrote:
> > On Thu, 1 Feb 2024 at 09:01, Lukasz Okraszewski
> > <Lukasz.Okraszewski@arm.com> wrote:
> > >
> > > > So this is a FUSE_IOCTL/FS_IOC_GETFLAGS request for which the server
> > > > replies with EOVERFLOW.  This looks like a server issue, but it would
> > > > be good to see the logs and/or strace related to this particular
> > > > request.
> > > >
> > > > Thanks,
> > > > Miklos
> > >
> > > Thanks for having a look!
> > >
> > > I have attached the logs. I am running two lower dirs but I don't think it should matter.
> > > For clarify the steps were:
> >
> > What kernel are you running?
> >
> > uname -r
>
> On this current machine it's pretty old: 5.15.0-89-generic (Ubuntu Jammy).
> We have seen this on Arch with 6.6.12-1-lts, if you give me some time I can set up the repro on that again and get the logs if that's helpful.

Please try on a recent vanilla kernel as distro kernels can have
patches that modify behavior.

Thanks,
Miklos

