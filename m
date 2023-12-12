Return-Path: <linux-fsdevel+bounces-5640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FDE80E7F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 10:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E56282027
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 09:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA1358ADA;
	Tue, 12 Dec 2023 09:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="F3t+10av"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1455CDB
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 01:43:12 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a00f67f120aso709861166b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 01:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1702374190; x=1702978990; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fw3mF8CXIKfaOqClGYNM3nfYh10fHUgVLKvwjntKCTE=;
        b=F3t+10avL20u2nQiaqZwuLtcID/fvkvtCw5MIHM8Zbq8J/Z0LmjqQISD7yH3HFTmdT
         oLoEVCTmkyEfu7IOqx4Oxq5rFuIrV5xdzl0wmsy99gi/Cpm0lr+hVYMYC67lkqmDTyCa
         hJSmt+OBIidzPir5FJCsISRLry8KrXEty+lpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702374190; x=1702978990;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fw3mF8CXIKfaOqClGYNM3nfYh10fHUgVLKvwjntKCTE=;
        b=C1cvqnRP/NsjVY94GGSaDQo/lsI2EtiqdqirZZNO4f96ytj4tiwQodGMaz1U4Wj8B4
         wit+NsjYNNQoR9XXHb0x5pd5Jk+2er8QPCAKiKX7jjaVhkBh3bnmMDUIvAv0CILed0YR
         sQzFPvg9M1TsmNLcsY/pZhGbkJL2cWPemrga9KA4nJnZu0tyavrtfnsqp6O8ExErNA6/
         B1mkO0Rxv+Ppp2np1nmlZPC+0mZlvXWMg/pnWjjjOB3PdR15if3tMOsrWhacAlwCZIX8
         9JXaurl+m4F31kCru4y2GmH305ymC/4FbQj3LwmY/MIU313QiIbCvIuOWNS+X6mBrzcP
         b30g==
X-Gm-Message-State: AOJu0YyEZn3JZABY5AIkBMRo0vea3e7U6wMc3NXZYd9+fTF4qd2QC0jx
	HzMkNubnBl5SX+B9pxO98vCFwjTEZQYjtu0cxey5vh5Vf1rIJobj
X-Google-Smtp-Source: AGHT+IGH0GSEygoVGnBny7aHl7FVH2AJCGKnIgEc+w7dGkSH9JS34NMEpGURcwZ3KDg0ij1t7fAfhKlpIR5qWBBlKYY=
X-Received: by 2002:a17:906:102:b0:a1e:f7d5:6959 with SMTP id
 2-20020a170906010200b00a1ef7d56959mr2571042eje.16.1702374190434; Tue, 12 Dec
 2023 01:43:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170233460764.12910.276163802059260666@noble.neil.brown.name>
 <20231211233231.oiazgkqs7yahruuw@moria.home.lan> <170233878712.12910.112528191448334241@noble.neil.brown.name>
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan> <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area> <CAOQ4uxiQcOk1Kw1JX4602vjuWNfL=b_A3uB1FJFaHQbEX6OOMA@mail.gmail.com>
 <2810685.1702372247@warthog.procyon.org.uk> <20231212-ablauf-achtbar-ae6e5b15b057@brauner>
 <CAJfpegvL9kV+06v2W+5LbUk0eZr1ydfT1v0P-Pp_KexLNz=Lfg@mail.gmail.com> <20231212-sechzehn-hausgemacht-6eb61150554e@brauner>
In-Reply-To: <20231212-sechzehn-hausgemacht-6eb61150554e@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 Dec 2023 10:42:58 +0100
Message-ID: <CAJfpegshsEWtm-dcdUy2w9_ic0Ag7GXpA2yRWGR+LD2T37odGQ@mail.gmail.com>
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
To: Christian Brauner <brauner@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
	Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Donald Buczek <buczek@molgen.mpg.de>, 
	linux-bcachefs@vger.kernel.org, Stefan Krueger <stefan.krueger@aei.mpg.de>, 
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Dec 2023 at 10:35, Christian Brauner <brauner@kernel.org> wrote:

> So taking a step back here, please. The original motivation for this
> discussion was restricted to handle btrfs - and now bcachefs as well.
> Both have a concept of a subvolume so it made sense to go that route.
> IOW, it wasn't originally a generic problem or pitched as such.
>
> Would overlayfs be able to utilize an extended inode field as well?

Well, yes, but I don't think that's the right solution.

I think the right solution is to move to using file handles instead of
st_ino, the problem with that is that there's no way kernel can force
upgrading userspace.

It might help to have the fh in statx, since that's easier on the
userspace programmer than having to deal with two interfaces (i_ino
won't go away for some time, because of backward compatibility).
OTOH I also don't like the way it would need to be shoehorned into
statx.

Thanks,
Miklos

