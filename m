Return-Path: <linux-fsdevel+bounces-5712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A09E80F140
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 16:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B481F210D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 15:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6AF76DCC;
	Tue, 12 Dec 2023 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ePLs+thr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9249AEA
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 07:38:42 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a1f653e3c3dso600670666b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 07:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1702395521; x=1703000321; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qDZp7gWbuTVE22AvhJgQ9vIXXo9oTgtdlKx+S8j/dsw=;
        b=ePLs+thrYIrckuEll35ovE9pmJp5cwokHTvPGSt9XpSrlwBHAdYY/R2Aa58IidFGwY
         dhfMNhx0XPeLeVDliY50RMI9d9CfMfoOfJMvZcRLjPqSTwO2mLwhQA/WflpZiIFd6soB
         NhFBy50pbUzvBumih5waDU+xa1DM15XnC54gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702395521; x=1703000321;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qDZp7gWbuTVE22AvhJgQ9vIXXo9oTgtdlKx+S8j/dsw=;
        b=Zpzr+I/Rtmfm6+FFmrwr5U1j0mvRBN/i+5y5xQsuDgxGZrWgNuilpr8NQwaBZIa8NN
         4Qt7WuPmYnlFHuepS0s3xn7rIpcYK40PNQw4o7pNuQEX8xSuxAfwjraWr3EeX7x4DBHg
         dq1XYraozRwrcFXAGZxK6KToxHU71rQ6gKRVI45VQNajbsNigIRugQUd6F1cfDyUokkU
         E+q0RbNs3omHe5sTa2bswf0OpdySOouww03Bm/7q1Q8IycyQbuDfgqsachJDWSEEB4zD
         O8KA9zsvZP5fo63NsNEfBxLHdU11GMAnWq/heLDSZZ35tlRX6wg3PEvq5ItJIqIZt16O
         JfHQ==
X-Gm-Message-State: AOJu0Ywc8I7KQxGqqK4tnUzof/Vu3jJX9M1aD+jJHEEV00VoSzdLdoNn
	cGiDuvHXwDpyUN4A5HF5SUg/J2AgkNUodT0hruYJMw==
X-Google-Smtp-Source: AGHT+IHmZCdgCSlsAh5hzabUbuYuMUlh4UtiP5FO9/RLbX9bRONO0dRdKVOceruL+MQnVZvFpB3AboTApbM1hEUFH3Q=
X-Received: by 2002:a17:906:10c4:b0:a00:185a:a12b with SMTP id
 v4-20020a17090610c400b00a00185aa12bmr1425258ejv.34.1702395521086; Tue, 12 Dec
 2023 07:38:41 -0800 (PST)
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
 <20231212-impfung-linden-6f973f2ade19@brauner> <20231212151631.wi7rgawmp3uig6cl@moria.home.lan>
 <20231212-neudefinition-hingucken-785061b73237@brauner> <20231212153542.kl2fbzrabhr6kai5@moria.home.lan>
In-Reply-To: <20231212153542.kl2fbzrabhr6kai5@moria.home.lan>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 Dec 2023 16:38:29 +0100
Message-ID: <CAJfpegsKsbdtUHUPnu3huCiPXwX46eKYSUbLXiWqH23GinXo7w@mail.gmail.com>
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>, 
	Donald Buczek <buczek@molgen.mpg.de>, linux-bcachefs@vger.kernel.org, 
	Stefan Krueger <stefan.krueger@aei.mpg.de>, David Howells <dhowells@redhat.com>, 
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Dec 2023 at 16:35, Kent Overstreet <kent.overstreet@linux.dev> wrote:

> Other poeple have been finding ways to contribute to the technical
> discussion; just calling things "ugly and broken" does not.

Kent, calm down please.  We call things "ugly and broken" all the
time.  That's just an opinion, you are free to argue it, and no need
to take it personally.

Thanks,
Miklos

