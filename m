Return-Path: <linux-fsdevel+bounces-20146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A698CED40
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 02:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE4D5B222A6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 00:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B9346A4;
	Sat, 25 May 2024 00:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdiYzJEo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5F12913;
	Sat, 25 May 2024 00:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716597851; cv=none; b=o37VGuoP9xtPKGjX/FREcjVnkvu1qfhg/TGSqtCKtBjp29StosLLd1PWJz0kRV0IMvht2nBnVlupCsJTxROLwnelcImWDnVva4ztB27qBY6BnTGXlP+CJV0b0Stloutk3RswkJUM7ykoeCQkv0LXvAR9gyXBk5LlRA3Atc7w3TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716597851; c=relaxed/simple;
	bh=wxIJIPCIKkt3/mHS0ipe4p00+OQoqeZ3PhggMkOF4GA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/OSXI0y12qttp3vFBUhPrPcGaFKqkxI22qrIKUJO39yaaQEBMSVqvv32cPkH/el082amBTTyIyqPwUimmi2zZYJQ3CVxNnmsKp/CGB6inB8IKKFZdXIev6b4pYrDesrEe/l2WvAQyNqNHw9ROFaNGqILGYsvYynw/keYmHSC/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdiYzJEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D204C2BBFC;
	Sat, 25 May 2024 00:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716597851;
	bh=wxIJIPCIKkt3/mHS0ipe4p00+OQoqeZ3PhggMkOF4GA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pdiYzJEo+n24UbPs/kiRny/2UJq8iEYIZgCmfmTxkGiyh6G/i28gmyFwGEBkDQ5OW
	 JBLBgvWG4fHnFEQ2m0bpZ+VA4LW5CjB5/j4HqJck4uxOLqWoorFrm2UB4SgCR6XWO9
	 7iLqmQYCHgN3lbPChAY+UUOfemxxPSiax5UdwXLmcodvNaHJolWqMa2hXrHHDOwRvi
	 NXzKwdlI8vTnGMaeVaX0PmM2L9l93QPn1MmWbvQPbl1TXJhYPhExr9t1zQVuGUKo+H
	 kFPEt641aWtJzDW5cshtQa7FhCM20eSPFuJw+cmzCLmGMNI45/irc253+wNis0jMs6
	 29u3Ex9lxyV4Q==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-24ca2f48031so528774fac.0;
        Fri, 24 May 2024 17:44:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5afPJHiJ87/euaJF4K86IDDgfubhfaleeReas4V8arHLHz4HejQqr/Fkq+2HmQlfb/SaLe/n9wUx55VftysmGjvoU21/50gWzkbsyRMYSGgZBargYB8WMLvVCwdMXJ4+8icWUh1tIC3dxwQ==
X-Gm-Message-State: AOJu0Yz4neM9ZW39Q8U4ydUtNmw+87+gtaOPx9X8l/c4zNYdSMcgAqEc
	J63yS23cMEz7vP2jhrYk4jdFZLH6aoj02PIZWhu3ms3NtvS0k7L7+kIQtKbngU6EoR4U9eRouyq
	59fsvlsw3C2CjBJ+H8jtALApQniM=
X-Google-Smtp-Source: AGHT+IF8V1yjUzhYESzNGzk/LDl1bR3MGUITNwyD1iX0TaPnaezpJNCrarFH0vHbbisewr3/VLqbRszPNzlvV46JTZ0=
X-Received: by 2002:a05:6871:a588:b0:220:6edc:1fd7 with SMTP id
 586e51a60fabf-24ca11f424cmr3993002fac.1.1716597850415; Fri, 24 May 2024
 17:44:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523011007.40649-1-mjeanson@efficios.com> <20240524-verordnen-exhumieren-2ea2e8bc2d08@brauner>
In-Reply-To: <20240524-verordnen-exhumieren-2ea2e8bc2d08@brauner>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 25 May 2024 09:43:59 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8A=t2=gJO61m4kt+NHQnjzBTsBweZ1EW5EFbxY6YH9nw@mail.gmail.com>
Message-ID: <CAKYAXd8A=t2=gJO61m4kt+NHQnjzBTsBweZ1EW5EFbxY6YH9nw@mail.gmail.com>
Subject: Re: [PATCH] exfat: handle idmapped mounts
To: Michael Jeanson <mjeanson@efficios.com>
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, linux-kernel@vger.kernel.org, 
	Sungjong Seo <sj1557.seo@samsung.com>, Seth Forshee <sforshee@kernel.org>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 5=EC=9B=94 24=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 10:58, =
Christian Brauner <brauner@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
>
> [Cc: Alex]
>
> On Wed, May 22, 2024 at 09:10:07PM -0400, Michael Jeanson wrote:
> > Pass the idmapped mount information to the different helper
> > functions. Adapt the uid/gid checks in exfat_setattr to use the
> > vfsuid/vfsgid helpers.
> >
> > Based on the fat implementation in commit 4b7899368108
> > ("fat: handle idmapped mounts") by Christian Brauner.
> >
> > Cc: Namjae Jeon <linkinjeon@kernel.org>
> > Cc: Sungjong Seo <sj1557.seo@samsung.com>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Seth Forshee <sforshee@kernel.org>
> > Cc: linux-fsdevel@vger.kernel.org
> > Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> > ---
>
> Looks good to me but maybe Alex sees some issues I dont,
> Reviewed-by: Christian Brauner <brauner@kernel.org>
Applied it to #dev.
Thanks for your patch!

