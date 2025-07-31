Return-Path: <linux-fsdevel+bounces-56447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F89B17774
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 22:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F2097AA3B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 20:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B381621A43B;
	Thu, 31 Jul 2025 20:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bpz2td78"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912D9481B6;
	Thu, 31 Jul 2025 20:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753995296; cv=none; b=HNklOxfrXMioiNC6SgtjOuMy0Nh4SpXjODKCdYJ7c0JAieYXEyVJ9vBH+1kwQFM7g/S42yKCN5nK+Lat7fFpHMIjBybLyJ7F0PbXMb8dhvaOPre0NhGhgnAdu2zAEIKRFs5M/aQoZg3Auvt39eryk/9Gkl/NWTB+I/pyOnHfnOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753995296; c=relaxed/simple;
	bh=GsOkGBfNnX13+Dzx6YT5tWAPgYlyl31wbbwp1SGZ+hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=niBMkuaJaTGWQ9K3qIJMPmi3K6CSDQAvcvyNFKebfLY2fkpOj+EaQWktMOhfiWp0q5LgKkaSoD+2dfcGsMIs6160dxZK8IHaxT25eb1fF+uh4Bi92a33B1Op389fu6Ha5aQRzEiwsM1w8oD0ADcFf6lu7sqP8b2gIn8fT0ABDBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bpz2td78; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4aef6114494so11720421cf.0;
        Thu, 31 Jul 2025 13:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753995292; x=1754600092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsOkGBfNnX13+Dzx6YT5tWAPgYlyl31wbbwp1SGZ+hc=;
        b=Bpz2td78piejjdWhB+yF0Crld4zOdlUE0LUH/ai0rHNu58d7yTYswQuT3cB3GnT46P
         GS58G27QMt7kvROgyugHxAVJaCNbUcfW4r+9GV3hsp2lgv+BSpPs7ijhVTMjxNQvsf9a
         zy9iqctPcBMKRRtRybWq7Z9EzF/45bPz8Xv6m9pw/vTQF20LirEIbLiFeHsKldf4N9oD
         2UuUCZzRPJhH+5QGjG00CaASxgAhq+zpVlR59fOpqHzVAKH7SdBzrIRHcFQ7dQtjZ5Iv
         5yt0shAFwLOsKnrPtBlRxm/CDJmGar419PyVDZM6BADWosdZCbKRxOxS1XEwSYzTgvSA
         8NaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753995292; x=1754600092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GsOkGBfNnX13+Dzx6YT5tWAPgYlyl31wbbwp1SGZ+hc=;
        b=LsiFKr3cIzIDPlTWKcrv9WsG2qrS/1xMiQoLXgILjuK/qa0p1qrXB6rNJSd9fiobea
         w6OYXi+xJvdhTCk7C4VlEzO8VDgQ9/Kx5YlFnhel9xixESNOXt9pz1fwXSXhG3zBnDzV
         976lh9V9GRW7g9DF3f06/MldlaEafnbC0dQ5o62gPKK1jtDUM6pcVPhp4CNAcYsOeTjh
         4yJYy3KoJRtb8T2QkmpVVL5JmLCa6v7pn8m4RsFsV/nMV9U9Fk2l6VWGaoWHl421INl+
         XBE5vfGmueX/dFvHGCQJsBxZ+HDnu0L9TI6M7yoD10Yx0AHLjg8b60Aql0VPJB6X4FJq
         9J0w==
X-Forwarded-Encrypted: i=1; AJvYcCUjj/nz7XEH4HztqmmyQZoi5op6S8Wmx8m2IF9eRdR7YcLT4nBWdKuw15uqVIAKLhF/7gOdp7ADvDBOL1Gy@vger.kernel.org, AJvYcCUjsJmPno1KpEwiX6+Sw/4Y6E60aTO2at1gY+uKbkqs9zbgdvOHnljo1ilSR5PDjpSLdddkNyDEzSbwnHxp@vger.kernel.org
X-Gm-Message-State: AOJu0YwNm61rpprNjWAlKDK0UWA4pvSCeD+5m6aZJMxFlVybqvR6iqni
	u6tgl9xY/j3e9AXOddJJec2aBkHdyDkGtdO8gQF8sugZQ5JnRRMlwqXtsBywf93I5AWvsjP+n5K
	lqAydtAW0T+Yx5uV8hr8qaqehpgtQh4Q=
X-Gm-Gg: ASbGncsPjm2BebWBO6p8A+qGixnm9yjT55A81pm/prI19Wh0H+lJZQoij9u7F7+yRfk
	83zxwYNdHaj+LcNFzNNBvLuveMMdrWuyVeecOjqRjTD8r6COwNReG8nFaWWmbrsuT/61aIqSjNN
	EvGhw5Oe2gZ5AZaF0B1fYtobpokKymK3gxHZmGw+L6Ox0Rjr7AZXN4TDoLXD1U0Pdr7ARExGmDo
	DK1+6Xk6ZnQRC4Nlw==
X-Google-Smtp-Source: AGHT+IFXugrVrWFNEaAfbeKAvbUs9wQetuvM3ASm++J5Zuon9sJzUqEj5T9+1y4E6VayPNJcawqm3+K0KpQpMG8s7f4=
X-Received: by 2002:a05:622a:7b8e:b0:4ab:63b9:9bf4 with SMTP id
 d75a77b69052e-4aefe09b67amr8989581cf.1.1753995292295; Thu, 31 Jul 2025
 13:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730130604.4374-1-luochunsheng@ustc.edu>
In-Reply-To: <20250730130604.4374-1-luochunsheng@ustc.edu>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 31 Jul 2025 13:54:40 -0700
X-Gm-Features: Ac12FXyF0pSGF-b2VZ0LIN7kUr_JVU6GGXFUm6dJYIHAYnw5sawYZCkQDACY_eQ
Message-ID: <CAJnrk1bp52L_qgjd2zcu0pBaOQO0fEdJpTLGJnr5R8EqPxVhfA@mail.gmail.com>
Subject: Re: [PATCH] fuse: remove unused 'inode' parameter in fuse_passthrough_open
To: Chunsheng Luo <luochunsheng@ustc.edu>
Cc: miklos@szeredi.hu, mszeredi@redhat.com, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 6:06=E2=80=AFAM Chunsheng Luo <luochunsheng@ustc.ed=
u> wrote:
>
> The 'inode' parameter in fuse_passthrough_open() is never referenced
> in the function implementation.
>
> Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>

LGTM
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

