Return-Path: <linux-fsdevel+bounces-26358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D689958349
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 11:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61821F254A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 09:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C41B18C01C;
	Tue, 20 Aug 2024 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyUAi9Q7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEB118C00D;
	Tue, 20 Aug 2024 09:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724147699; cv=none; b=nz2wzY5LplrnDC4H8/sKcvDKuEw4z9InG5go7/XaINcw7EkTfojm4dTJYawOw8TiLcc4pJOS4his0fwwqzyg4By3PzMYKO3ll+W38rYprM610xKRwATYeQrC0gYI+QKpf3tQqQQZ4LJE7bBOttcc2SALpQNFBXOcCVLJq3FP3ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724147699; c=relaxed/simple;
	bh=7wLbMmT0cymuj60iU2xcEmfyuNwxpL/PH69BMR1wDNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mtzm8PMWyvvyjjHW1YJqBlhi4LBFVpzT6xQ0YN3RO88VU9xKM5o8erAoDmGDx9pozcPMp1TYK3K93XD0HEslu7PH7C4fTanCmCOrLycJbyI/A+nACTwtfh5Mtl32/7MfHWnnOxut4hiXl+3OMljb0pwG3MtJnxJKu0/DPSZO3GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyUAi9Q7; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5bef4d9e7f8so2884980a12.2;
        Tue, 20 Aug 2024 02:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724147696; x=1724752496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uVyAOTP+cI1Nk3qF4l5hctewWGZnAnWEVSxLItpk9k=;
        b=PyUAi9Q7ETBgLbYf5qFTIs1pNxB+awIgRpfJi0rR8ExLTOTb9L6RV4+vF/JwsgNaZO
         tksq423zMmuUcc3CNxC3sQkVR+Ewsa4d6LLy4DuJdZ4linSNrXFZFxMVaNpcPFCNGsPJ
         1Q3uk6wh3rrWArU3q/fN9F08REfQyrpO4hJ2zKn19k+MTSK33T4fuePUAUxVsKyxxPqq
         9ZGbKd3jyErRJg9E5FRjQ/gbLJbFWzLxLJkblwlNqtq2sLaJn4zRW5mmRAiMIdq/vEdh
         DjzekQIHw3tluhyI2MZXcArNemAWI8NZCqZ3xiDaxHjbk+cZF3fwuOZVyHD7NnGwCPFs
         DqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724147696; x=1724752496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uVyAOTP+cI1Nk3qF4l5hctewWGZnAnWEVSxLItpk9k=;
        b=UvynWesTCl8qqppzJFojqHYoJ9zHMIhv809Wv/TUhxT9LPJO5/34zNjiIlQhCjjBl4
         +vIkwWAAgsgOx/cOzTfb4S+uDJlYVBENi7MKv5al0eUSmPAGGmi0FrJhW+2MvY/k5Lp3
         ZtfoRKE20Rww3bzpf8SVk7at3EIE9O1dLNq8c0KUbvRw+seL/28wLvwdtSCCE+UDMTrM
         OFWh98QzFnzKYzvft6espsr5+1vIARtjt00dnduSOunQkm+EzjHfSw8bFrChjdl24HLu
         V3FLE9lBdr1vrINnE6zjGJT1CsO2mtNHv4Fynd39IEzlK8RTQSEhCgZDcd64jPo/7y/A
         qD3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuUHiGwuuB8EOSVzVI2pQlQz5jaLEVd1lK/7FgkkwP8UcCpLeoHqagfJ4B//kavfCinEmftPggDJp3UdEq8huBqQPD0CnMGZ8NlfSbnw==
X-Gm-Message-State: AOJu0YxMhUGI4Pa+c35Wvb6FFLasdtjv8DPtOSI83f9QYeWRAAlYW094
	q8xMlRJyVIZWtoS3GUOI+xQecXVyAtUFO490tQ2OGvEE3ftbGb96qObMyD0BAn4KBPNTjYiwcjH
	wovDqQBIAFV5MNKu0Ezm0EpSRDZItqBVzdgI=
X-Google-Smtp-Source: AGHT+IHuM5/0QGY0ecxei/ODBj2RXcPAwWdJVE/jGIbBQmVLl+0lkbe5s424RPR7HftbauNYEvRDsGqGpqVGr+WPzms=
X-Received: by 2002:a05:6402:40cd:b0:5be:fe26:daac with SMTP id
 4fb4d7f45d1cf-5befe26db97mr3536460a12.17.1724147695315; Tue, 20 Aug 2024
 02:54:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820094922.375996-1-sunjunchao2870@gmail.com>
In-Reply-To: <20240820094922.375996-1-sunjunchao2870@gmail.com>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Tue, 20 Aug 2024 17:54:44 +0800
Message-ID: <CAHB1NagnXCDh_dVMX7TLBamtyF+G_1Ug0vohQg+jkJs8e2RuGg@mail.gmail.com>
Subject: Re: [PATCH] writeback: Refine the show_inode_state() macro definition
To: linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: jack@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	mhiramat@kernel.org, rostedt@goodmis.org, mathieu.desnoyers@efficios.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies, this patch was sent by mistake. Please refer to the latest patch

Julian Sun <sunjunchao2870@gmail.com> =E4=BA=8E2024=E5=B9=B48=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=BA=8C 17:49=E5=86=99=E9=81=93=EF=BC=9A
>
> Currently, the show_inode_state() macro only prints
> part of the state of inode->i_state. Let=E2=80=99s improve it
> to display more of its state.
>
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> ---
>  include/trace/events/writeback.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writ=
eback.h
> index 54e353c9f919..a2c2bb1cddd7 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -21,6 +21,15 @@
>                 {I_SYNC,                "I_SYNC"},              \
>                 {I_DIRTY_TIME,          "I_DIRTY_TIME"},        \
>                 {I_REFERENCED,          "I_REFERENCED"}         \
> +               {I_DIO_WAKEUP,  "I_DIO_WAKEUP"} \
> +               {I_LINKABLE,    "I_LINKABLE"}   \
> +               {I_DIRTY_TIME,  "I_DIRTY_TIME"} \
> +               {I_WB_SWITCH,   "I_WB_SWITCH"}  \
> +               {I_OVL_INUSE,   "I_OVL_INUSE"}  \
> +               {I_CREATING,    "I_CREATING"}   \
> +               {I_DONTCACHE,   "I_DONTCACHE"}  \
> +               {I_SYNC_QUEUED, "I_SYNC_QUEUED"}        \
> +               {I_PINNING_NETFS_WB, "I_PINNING_NETFS_WB"} \
>         )
>
>  /* enums need to be exported to user space */
> --
> 2.39.2
>


--=20
Julian Sun <sunjunchao2870@gmail.com>

