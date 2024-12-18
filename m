Return-Path: <linux-fsdevel+bounces-37698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728F99F5DC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 05:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97504166C25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 04:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B34B14A4CC;
	Wed, 18 Dec 2024 04:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dj2mxH9I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CD55336D
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 04:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734495714; cv=none; b=NZmIzwz/o6WDrjplXA9YPOOezdOAHH9bKCluEWlUjXDwaFmffc3iPrFueAx1/o7NiG1Yn+gRVL1cS3RC9OydPkg8pXt8p67TyxwaQFfAXrivYxgJn20I7n2ntWtEXOYrtlUQCU8aAZeEHvBYlrXsDFVolnRvlH/1juzGSsZXAVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734495714; c=relaxed/simple;
	bh=p7X6vl19xLD0fiInSSDuQJ9CbZFo8Vh7pDJnKFZOEcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BS+kz0FhFgegKTzkeAEiwR3bSjvNTkYSAVCS8vaH+/joY49/U3M1Y9rHu27UQVmbyurnMeHvdvDm7NFHdd2+/oOHBaV8H8FFpskgvI++YXwwuS6H+YhZbG8yKQ7BiUiTVkdrseNPKqaKz9ynvghHqMh57VEBIs2WbLO0KcyEN6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dj2mxH9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C9AC4CED0
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 04:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734495714;
	bh=p7X6vl19xLD0fiInSSDuQJ9CbZFo8Vh7pDJnKFZOEcQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dj2mxH9IQr9xxugXu7Rt7xFrn+JZzSx+N0FU44sokNk/eOdEZTBQpzskLLqbT7Cqp
	 n/VzCJVAb6vRaADY5BORQl97W5O0JKvpitVDyP+LET0xhy0pG/w3DhOFjREOGcH8o5
	 9S9bc/5BG0jm6ZU8TF+HDwNVGVPwtpZ3NeyEeu1a1ys2yt4mG6rjxFzYZwghcWrwiE
	 VEz/o9VvtRcX4Ws87sSAMd+CM7UMTfoqkdc5q8gVvHid1zg9T7G2+CU3NWDhBw6J7z
	 PoMDKELDMLM28JgZgamWm9VCR6unI6S61F1mVvxJ0uNE2Xet63Pc4hc2VeOsA+RL0c
	 aIs5KkFL6VgFg==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3eb7f3b1342so2573323b6e.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 20:21:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX8541hmPgl3ZNEa6sicdz8jK/LBCMdz4EksvwCDfDL272z3E4/RD06xqxV8HtipfwudsemXQIsNOXnfWQ1@vger.kernel.org
X-Gm-Message-State: AOJu0YxRsLpV6wmVJCjUgrWJpzeusgHZL2s2JYF73bteV0khbIKhL7Bw
	Uqnhmnjl2CvBbA7QFNMpoOmQDlMf20HGf1y8RaxSCJ+mIFDcQ9RIudFWeBsIuee5rpGBul8UzpE
	rWMj60r3+YBJJg6bYE+dob9mEJbk=
X-Google-Smtp-Source: AGHT+IHjx7gn9to1oh7nhVuxqhA7E8zxH1KG9cSyZXVGcMh3/jmlDl/Ribtxytc4plc5+qR5lyQdurdWqxj34IuqJwE=
X-Received: by 2002:a05:6808:16a9:b0:3ea:4bcc:4d9b with SMTP id
 5614622812f47-3eccbf420fbmr841662b6e.18.1734495713546; Tue, 17 Dec 2024
 20:21:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PUZPR04MB631652FD1320924CD92D5ABF813B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB631652FD1320924CD92D5ABF813B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 18 Dec 2024 13:21:42 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8-CcF1DqiL-ccRD=UqOBhWEZjTPxT9D=06VZQpRDiL7w@mail.gmail.com>
Message-ID: <CAKYAXd8-CcF1DqiL-ccRD=UqOBhWEZjTPxT9D=06VZQpRDiL7w@mail.gmail.com>
Subject: Re: [PATCH v1] exfat: fix the infinite loop in __exfat_free_cluster()
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 3:50=E2=80=AFPM Yuezhang.Mo@sony.com
<Yuezhang.Mo@sony.com> wrote:
>
> In __exfat_free_cluster(), the cluster chain is traversed until the
> EOF cluster. If the cluster chain includes a loop due to file system
> corruption, the EOF cluster cannot be traversed, resulting in an
> infinite loop.
>
> To avoid this infinite loop, this commit changes to only traverse and
> free the number of clusters indicated by the file size.
>
> Reported-by: syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D1de5a37cb85a2d536330
> Tested-by: syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com
> Fixes: 31023864e67a ("exfat: add fat entry operations")
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Suggested-by: Namjae Jeon <linkinjeon@kernel.org>
Applied it to #dev.
Thanks!

