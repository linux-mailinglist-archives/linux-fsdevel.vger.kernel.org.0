Return-Path: <linux-fsdevel+bounces-46434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F58A895B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 09:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47CE17D5DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 07:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB98A27990D;
	Tue, 15 Apr 2025 07:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEUvkOs/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FEC2741D6
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 07:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744703656; cv=none; b=VxJWR4GvC8Kb9tehSL7AtNR4572KleCfsoXMOWl6cpK5w3DKo6lJtps7+4eEARvV/5hAt4eXALcq/U+B7F6TJbQNiw9zIEW3x4vKJEd2ILFZsL9jcvMJd1JoEocH15zdWnrVGhdFMkUpy33TTzJNRZuFvcoEHvIZZzJPDIoUJwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744703656; c=relaxed/simple;
	bh=I8tBI8SXV3lnmciQ62zndKGnoSCxfB+WGdkZxfQYyNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M46DDdyOXxag+vJRISwJaGeKb88vBWschEBa3fa+38ObLIBOsJZn9JvOCpABWD1b++BsYs8J93Kl6ZxrBtutOfgNyEZi6V/Nc6/jbbucG89g/in5hO5gFEqAy4SHJ8novPlev/X0MsbSSOlQ1mUVMKinys3e7u9/C5LCz3ydbds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEUvkOs/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5D4C4CEE9
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 07:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744703655;
	bh=I8tBI8SXV3lnmciQ62zndKGnoSCxfB+WGdkZxfQYyNw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HEUvkOs/UbDvicy6orX+63PruPf3iAPysH+y+1CqC5YqYOk8gp6+URAqbOTjqpS1E
	 miAYNZCSllduo3MAUbVVljNKpd4oCMiVIL+5UBoed9rsRullRBPRqOHB3+hlRVX0eJ
	 4gcVqGyK/sdJf2u94OPxlMB1uBACZh90N38q/Beq+nFp9gjnttf92icvvRmLAGql+4
	 HIpGinW/a/kqayyTVv2IMHU3gv/xUIlxW9srnr4FYy8UAPzrJhOUMQvee6AeKAz0m7
	 uVmfH72a2tmUX9jXaSSG4PcnRDF5/fIRW9YJ5Hicc0hlZlAjGtyF1nQZ1Z750dj1kp
	 RcEB+hdAzI9aw==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-72c0987bc4fso1712990a34.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 00:54:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWuUaZ9hFlVGcopN2wkns3zah0fP8EhUCqpWcaLBtLV/Gaziytqp31IolKMEjoeyApKcb7CwjK05+4q8QfL@vger.kernel.org
X-Gm-Message-State: AOJu0YzqW1mFBvPMLO1HGRhqf+w+agHqAr3wBpVy4CPaAU5vEEk2vadk
	oOfMjm8/dKksb2g3hIi0IFwsv4Ri4djUVVVm3Vwj992N5htY5grCr2CAvTUHV8f77jpX+dne2Jz
	sYCLMcyXUxpQ/4+GD6auqwvvukGo=
X-Google-Smtp-Source: AGHT+IFtS/qxi8AiBjAbu0ab+EqsrbMi+b9+WbKey9X4IRTa7KKhmQ5YdmNAVY/eSkodt09BD4mLOi2/T0CsRkGxNRY=
X-Received: by 2002:a05:6830:700b:b0:72b:9e6c:9be6 with SMTP id
 46e09a7af769-72e86307e13mr10527912a34.11.1744703655095; Tue, 15 Apr 2025
 00:54:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PUZPR04MB63168406D20B7CF3B287812281B72@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB63168406D20B7CF3B287812281B72@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 15 Apr 2025 16:54:04 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8VLzNZnL+TN7y1Kq54ZmN6qaJ_pL9ui_1e2epYwYccrQ@mail.gmail.com>
X-Gm-Features: ATxdqUEwAbx3DMpNwLMQp77bMW5zbn0KQjjWJHDQPQsgQRo55u75CpfPNKgCAaY
Message-ID: <CAKYAXd8VLzNZnL+TN7y1Kq54ZmN6qaJ_pL9ui_1e2epYwYccrQ@mail.gmail.com>
Subject: Re: [PATCH v1] exfat: do not clear volume dirty flag during sync
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 6:41=E2=80=AFPM Yuezhang.Mo@sony.com
<Yuezhang.Mo@sony.com> wrote:
>
> xfstests generic/482 tests the file system consistency after each
> FUA operation. It fails when run on exfat.
>
> exFAT clears the volume dirty flag with a FUA operation during sync.
> Since s_lock is not held when data is being written to a file, sync
> can be executed at the same time. When data is being written to a
> file, the FAT chain is updated first, and then the file size is
> updated. If sync is executed between updating them, the length of the
> FAT chain may be inconsistent with the file size.
>
> To avoid the situation where the file system is inconsistent but the
> volume dirty flag is cleared, this commit moves the clearing of the
> volume dirty flag from exfat_fs_sync() to exfat_put_super(), so that
> the volume dirty flag is not cleared until unmounting. After the
> move, there is no additional action during sync, so exfat_fs_sync()
> can be deleted.
>
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Applied it to #dev with Sunjong's reviewed-by tag.
Thanks!

