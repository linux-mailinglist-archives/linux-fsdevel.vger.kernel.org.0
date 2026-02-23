Return-Path: <linux-fsdevel+bounces-77977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIAwC1B4nGlfIAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 16:54:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 918E8179261
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 16:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E8CB305560E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 15:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF913043DB;
	Mon, 23 Feb 2026 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jVnxqi/X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82B1285068
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862026; cv=pass; b=qWZD+GCCEL6RbBYpxQ5Ca/XrYvXQ8FpjgMPBraguOU1CXyvEa1ihhv0kkCtlExnmPtAJE+2TeMR9ZEUlv9lRcpV7VyHEYVZRI99vMFcrvjqhCZX0J7X/YcZplFNlnhpwq8OHYiB0RyRUutyr1PhQnrmk7v5mAXun6hFu6A28stg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862026; c=relaxed/simple;
	bh=sOPPv/zwE/NA5y6zhjRCiHV7vQj5BoQ8qchS8ByC/I0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCZ9RsTjqF6jriI4ZyRMAXjzgWCUinA3Fw5YLlAxdTl5r+4hkm1LkKY+C72TLCItJuMaJysddQVMD5JcpGJVDaBaOeR4GMW9iKXAL380bB+RccTBCPO5s0wrnbCaRKs1djemXARKEMuQLRQte5/RP3e/4S76grMPck1V/Ei6xzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=jVnxqi/X; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-896f44dc48dso40853276d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 07:53:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771862025; cv=none;
        d=google.com; s=arc-20240605;
        b=ONz52JdCOVw8L85WJSVzT01JyxQLEx3lRPEMccrmG1wA+6rMm0yFh/jqaztTDTiWEE
         c/l0oSYmVEWin4Fz06jSIJliMABuZ3PR6eBTIBxvqWm6C+oduOscuN/g88msEK9x2LOJ
         o5taoxHvy68jKNM+5C9uVgm5Zod1xab0HV0sLxJVVCegiivUw3y8Gi254+dtcn7tCmvF
         PKXCo+vwB+zBiayMq0hgGEYPRXG0tHyesvEJYBvE0CuQDU0FscbOGT7g+ZkxzHl9uyA6
         3te8XQzfTClSu7vM9fSctXTXVtL6vo0H/4NBM1emMV4BmA+fW6E72Tm2xf61tY5GAGt7
         Zh2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sOPPv/zwE/NA5y6zhjRCiHV7vQj5BoQ8qchS8ByC/I0=;
        fh=GY0Nd2+VUVonwMBut5/5ZvqwvvIbU7xU23OXjtGISqs=;
        b=HXFZn3P5Q9xxKTi6/xVATFaf/I8XYZH4TgtYW4SXCr8ByTLYYpn09u5Z36uG0lLxsq
         ng4wVsz32GoIvEZ+PihcVY12+570DlN5jPUEWkymfOJ8jlu7/kJQ8JXOpvvkCL9/lJAX
         UZ9YLHJgg+Y2miDyGIkkh21WgcwiNwHn3vu3Gj+YxULgCnFZQWjbDAopLAzavftZIvKN
         9rVZ1T6hhYGGcKc+35ADBVJPKlhyxeM9Qpp+uRtnJ4vgav4q0ya1F6RN5nt+3Vql9pG7
         Zla78DNyozE+KETXQ7pYrrnThHmHw4kJ1/MPB1D9OW0IFgmEHCMXriD+4F9WDLDKrhD4
         DT3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1771862025; x=1772466825; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sOPPv/zwE/NA5y6zhjRCiHV7vQj5BoQ8qchS8ByC/I0=;
        b=jVnxqi/XuYkCES8ezL6FoRO0T2LpMP25y5AJoGoTLE4+TSJQjn8+9eEIckALaxoX8T
         ElC3wb/YvKpcf4O6TUUczC3GgI9SuhLuQpeFx/lu9w5OZJa29EPg3LLFfg9GrLZfSm4l
         GqLWLt2Gtc5nOrZjmriyDITi8ouePY2veOqik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771862025; x=1772466825;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOPPv/zwE/NA5y6zhjRCiHV7vQj5BoQ8qchS8ByC/I0=;
        b=uJ/TE0PaZMg59n7Bqgk3X1WM1fRV22EViH6Kur3GZKdeiTwdJ2ncoTzj8Maa13IlZt
         IOOd4oWRWxTAWN+mu+zj0uxRhnaf3gGNtlBj2oDc4aTb/LnQqfPrC7lmaVZiWvor1tD7
         TwZgBJuh/yk14e0s5cavtvSv4p/pB48Kd7ohGxBYfLtwWwjrWcl+E9U/bp9csiiqF9Za
         yckrrUX+GttCwxIwJwDKbo3mvWY3n22X2TcqjG1LMaG1cgrV/ujvVNZgm7JdF74vhW57
         qIbBHHNiCwmG8UewiRUmPcXgBV38eMmAIF4hk4LxUA/LHHLClOo+CtTYdLbEZsChyC1l
         X7BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMLjmwEWFtZDACrUZ8zMhuSYygOJjgYeC3xDySlSwP4Yc8TXedKrusy/ODYZAfk2RELI8iJJ+g4JrbEE+I@vger.kernel.org
X-Gm-Message-State: AOJu0Yym/AzFTSTy8f+dT8A+3W1+LTXsg1bULhDy2D7tJH59o6yjkOn2
	aJkM+ZrsVAti9jlS6pX1GjxOheWX8JvW0wAddQ8cOy28WZ8BNPHUyD2rlmvDL0K0wQmmDoWJ7Gq
	3Gx5AN2uUkq45nfaHyy/6gV2C44nXp/i9GnoQ29duUQ==
X-Gm-Gg: AZuq6aJbn0TF5Pe4OXClwozXMej0ql+VGzVIfd9IFyhqJGIearK5gzuTaVkvWPGYg4Y
	TOxKRyYzTHxg80PSUAfNRdQem7CBNBJYDsTlIo5DkLQt8FG0v2Hzfhk+m5Mlp9VNup/6va4jTVT
	YbhYwBWnkl8EwkwirvyMafvaihxQCB//Kq97laoRK65rgp9CbWLYeq+5fw3ccZ4xHxrkg9ZIkTc
	u+t5+5hE68FC2uFqHD0zeHugraWp2ASKpANbsz9mO8Kz8LsauUwD9CmAOKumGMqaqO7/a3Sg8oN
	3idmrTTpwOqZ5whT
X-Received: by 2002:ac8:5f07:0:b0:506:bdd1:794 with SMTP id
 d75a77b69052e-5070bcf357amr118296191cf.76.1771862024742; Mon, 23 Feb 2026
 07:53:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220204102.21317-1-jiharris@nvidia.com> <aZnLtrqN3u8N66GU@fedora-2.fritz.box>
 <CAJfpegstf_hPN2+jyO_vNfjSqZpUZPJqNg59hGSqTYqyWx1VVg@mail.gmail.com> <fa1b23a7-1dcb-4141-9334-8f9609bb13f7@bsbernd.com>
In-Reply-To: <fa1b23a7-1dcb-4141-9334-8f9609bb13f7@bsbernd.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 23 Feb 2026 16:53:33 +0100
X-Gm-Features: AaiRm51wcz1gc8Y7JK17jfy1hT5btKMqfSSNrJm1vJ5XhE7yH-gFTxBi-GinsYU
Message-ID: <CAJfpeguoQ4qnvYvv2_-e7POXiPeBR2go_J68S2E6c-YW-1tYbA@mail.gmail.com>
Subject: Re: [PATCH] fuse: skip lookup during atomic_open() when O_CREAT is set
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Horst Birthelmer <horst@birthelmer.de>, Jim Harris <jim.harris@nvidia.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mgurtovoy@nvidia.com, ksztyber@nvidia.com, Luis Henriques <luis@igalia.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-77977-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[szeredi.hu:+]
X-Rspamd-Queue-Id: 918E8179261
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 at 16:37, Bernd Schubert <bernd@bsbernd.com> wrote:

> After the discussion about LOOKUO_HANDLE my impression was actually that
> we want to use compounds for the atomic open.

I think we want to introduce an atomic operation that does a lookup +
an optional mknod, lets call this LOOKUP_CREATE_FH, this would return
a flag indicating whether the file was created or if it existed prior
to the operation.

Then, instead of the current CREATE operation there would be a
compound with LOOKUP_CREATE_FH + OPEN.

Does that make sense?

Thanks,
Miklos

