Return-Path: <linux-fsdevel+bounces-34737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F679C839D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 08:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4C71F21FCC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 07:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976BD1EE018;
	Thu, 14 Nov 2024 07:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esufXvow"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58589163A97;
	Thu, 14 Nov 2024 07:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731567760; cv=none; b=QnKGCXPmXvif5CX4su89RRH8BV45lGb5ZXAaj3nvS8n4M6O1+gb2Dn+xPOz56ppPHOTy+MUV465Xadf7hcQkxAA9zSLfuyctHaeSPMsu0roTqhSKaGYutf01x23Lo1ImggTvJFqM4ZfA3E3VCVVDgRp5Xl+MuDhMz3tI7yChLdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731567760; c=relaxed/simple;
	bh=5k87BJrsuqGfoYky9N4Z8TwX+i8nHpnJX4NyHG1Ze2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FgX2/JfSs+i26NGBoB12fgyNqTGfZgHDa59DmOP0t/efdaNgHUUjc8NNG4NVJeqHaieiSYG/LZpu5fdk5Bcbc9EDvL3Oy+Q829VbpopOfSDN9h7WRudOVPVxZU1JIdl9ApUv0E36ohF+TJ+cjEAC2vn9/YF5CpIZwG7vUYt7y2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esufXvow; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6d3f3925f57so617786d6.2;
        Wed, 13 Nov 2024 23:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731567758; x=1732172558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LaQLOyvMlaZPfOmJIeYskTzRF5rdE6NW7wBfpWJVfco=;
        b=esufXvowouO8CYVEQS7l+6Tjnsf8lZ6iNbNNAkVyjcuQQtcOsNz2qK7oEwEkdNTAM3
         YCj8j1W+30Lwx8SXDFHN3FNC3EgKogiGcEv5b7Iycdc1uRA8tsaA/nTxISidUqt37lDJ
         xGY7N+WshRLJkrkrNTEdggGnaSR1aS5S4xONzXWCZuBp3+eA94dNPa+Vo7gL1JRdSEBR
         T2BfY1SQKYnYMH5f3vo9hgTw/w5V/xngVAzovSu7xpMw8f1yVnO3IuBZbi8fTHcxZHQ6
         O4skLlvlphj5zcCcoDLvmJ06vAqqCMksjrbI/hNUtYaq2l6ZJL0Jv+fV8DLBCS0rOEKI
         btBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731567758; x=1732172558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LaQLOyvMlaZPfOmJIeYskTzRF5rdE6NW7wBfpWJVfco=;
        b=Te9guG0gO6w822PDx+Kcl61UgQZMSZdR+l/UTMh9nCDRhQquZj8hLL6gPw5DQXCHIj
         tGG9FBiyMI6djwKHJB+K9+r928ayilMxRJpeM3p/iCCka9qyuRIV+bVeSIXC40u0qpiU
         n5b7EGSpYB/UThFWGbzXujfuCRyHuJfz2BpisMdf6/bdF14mPVfkMgMFeiJTO47eMfu6
         g/IlKngUH91A3k6huyaBPsZKRdB5PM8YAVn5eHCbEPzziwqwdSnZ0cX5TugJIHblCd69
         DN7JN3FwkFEKO0Sma7TqhPncthg7TkV55uwICv2idZn24AAZ6xTy6/vce9aDvL0mZuTa
         8zRg==
X-Forwarded-Encrypted: i=1; AJvYcCWf3tCqBNFT40kfgHjt6cTCPvl8TOzQUoIbgoTZnU4ft2yJeKcqlLdgFsIB6tpHP/pDZbn3992Sp/s1@vger.kernel.org, AJvYcCXCmNOwFxpNritNRj9E6hjvjgtRn9pMAJSkadZ4YhwYAb6cQ7HZwpbkCO1KzekyJB8rXBfTujDQajkCe2KV@vger.kernel.org, AJvYcCXebGOoFXdL8H84PmcPYIxgCtQXWsro9aKjfDH2e7IBQMKYhpNFObhwi8Oi8gOAQGEHrgJpIM+jhMSUCS6q@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6CcE0mN1TF3F7qzgeMJD9nrZtfCvql/aevIrlBYnOaxWtQc6J
	QPfpLKNDPgErbjeJHjQFuZVQXbxS8PUI0TFYIi9u2JtTYMk8zycyL03mfFiSAZBKfhZuPAcwtkZ
	E5hlRe939kcY4Hi3mXFZ3P3iYkLKckUav
X-Google-Smtp-Source: AGHT+IEqWEblVL7jQPRJEvw5AOInXXrSLmcl0RUUq+mtq19C5T5Ege1Jc7JnaJpPfxvnq3Ms+c4X0B9uX1Qtg/t1/dI=
X-Received: by 2002:a05:6214:3d89:b0:6cb:c9d0:df32 with SMTP id
 6a1803df08f44-6d39e17c2b6mr327856426d6.11.1731567758276; Wed, 13 Nov 2024
 23:02:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2aa94713-c12a-4344-a45c-a01f26e16a0d@e43.eu> <20241113-pidfs_fh-v2-0-9a4d28155a37@e43.eu>
In-Reply-To: <20241113-pidfs_fh-v2-0-9a4d28155a37@e43.eu>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Nov 2024 08:02:27 +0100
Message-ID: <CAOQ4uxg4Gu2CWM0O2bs93h_9jS+nm6x=P2yu4fZSL_ahaSqHSQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] pidfs: implement file handle support
To: Erin Shepherd <erin.shepherd@e43.eu>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 7:01=E2=80=AFPM Erin Shepherd <erin.shepherd@e43.eu=
> wrote:
>
> Since the introduction of pidfs, we have had 64-bit process identifiers
> that will not be reused for the entire uptime of the system. This greatly
> facilitates process tracking in userspace.
>
> There are two limitations at present:
>
>  * These identifiers are currently only exposed to processes on 64-bit
>    systems. On 32-bit systems, inode space is also limited to 32 bits and
>    therefore is subject to the same reuse issues.
>  * There is no way to go from one of these unique identifiers to a pid or
>    pidfd.
>
> This patch implements fh_export and fh_to_dentry which enables userspace =
to
> convert PIDs to and from PID file handles. A process can convert a pidfd =
into
> a file handle using name_to_handle_at, store it (in memory, on disk, or
> elsewhere) and then convert it back into a pidfd suing open_by_handle_at.
>
> To support us going from a file handle to a pidfd, we have to store a pid
> inside the file handle. To ensure file handles are invariant and can move
> between pid namespaces, we stash a pid from the initial namespace inside
> the file handle.
>
>   (There has been some discussion as to whether or not it is OK to includ=
e
>   the PID in the initial pid namespace, but so far there hasn't been any
>   conclusive reason given as to why this would be a bad idea)

IIUC, this is already exposed as st_ino on a 64bit arch?
If that is the case, then there is certainly no new info leak in this patch=
.

>
> Signed-off-by: Erin Shepherd <erin.shepherd@e43.eu>
> ---
> Changes in v2:
> - Permit filesystems to opt out of CAP_DAC_READ_SEARCH
> - Inline find_pid_ns/get_pid logic; remove unnecessary put_pid
> - Squash fh_export & fh_to_dentry into one commit

Not sure why you did that.
It was pretty nice as separate commits if you ask me. Whatever.

Thanks,
Amir.

