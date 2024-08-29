Return-Path: <linux-fsdevel+bounces-27759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAFF963924
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 05:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107352865E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB806A33A;
	Thu, 29 Aug 2024 03:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YB4D7MW0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B73E481B1
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 03:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724903954; cv=none; b=q/XfCHWnX7p5Cy9KALzXmcHcSlDaMcSwetTmGBxSBJYHkj/NGi3In76nSyjiGEb1p5d5tWTnQ+L54uW95uLwptStdPhx9mci/NAGeoYvVtkAuk39QZalqpqHdD4M+Mjom7KCP3XWnePxteL9uzJmUjf/HIVcx4AvXYE8CI5huD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724903954; c=relaxed/simple;
	bh=oS3Wew+q5mdFePU9SpJOR2+UjomrZ0n/Ii/nChpH2to=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vF7jJ7AgXcJspE7k9iXCMV1phnMo8d8RLoUobptycWkxfCkdkH7GR8QNakGnpIyGqMQrd2qKvl08IsdsgwdFVQtG7OSKzYdD9Vq4nLIiOXimhknLm+VtZ5LVdBgJ90rOIHWmIaTyPSK3Zq6V4WCEVcwq/hyxVnbhsEjpy0W6jDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YB4D7MW0; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6bf7ec5c837so1168676d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 20:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724903952; x=1725508752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkUS09TgKftE5W/7Kxc6xlgjZNojsIxIrYnirPLk26Q=;
        b=YB4D7MW0GRNbkoilDeqyMLi0ieYxBqwW4qcjfohNIdS6HVG7PKSDufXSreHpH4X5Vk
         v/CxvupbVllTTdKnJJMB8oHOps2v6fNdF3mziiPdCAKZMDQSNvoc1Hae0i7zd6UZq2fu
         hcPbAIz7oR/QELzOKmxjLsO1aqRfA8cueapYu8vj9QfB8HUZPPXP3t1MEK/tBBsjlon/
         VEc7h5t9sC32wV9cMClCGOiQ7v1t6S2hOBg2ESxpVLUGOdbI/U985tBap1ZookHkcN7G
         zT606MRedSmzQKWu4QfrvTlHynxvxE5fIo6iOjaoeMpn2xJgsFohkROJSTAxjTYIMAfN
         jF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724903952; x=1725508752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkUS09TgKftE5W/7Kxc6xlgjZNojsIxIrYnirPLk26Q=;
        b=eRyG8TsCbpfAwE/NqBDXvO/uHRZy+STEY66Ws/qXs1cPamLYxUZCLnRE//RA84AnIR
         Pi3yZDaCNzuKYJOb+JN6T/nlhmNQBOLZUHeHQG9GINFxyK1AaQ3ynO/MocszcctuvzRf
         hHcTeTQI/TrmIC8OGaEfzVxZv3OEX7h6F3tRC961HzXzO4diSQcHf+/lUOY3zBCnlSt7
         V0M6nl6+bfi3DjqYtzK1TF4VMnBrRBdDzzRJCPn98Z1y4H2OjF3Xetkzj0vM/1fBjwVQ
         bWB0UIryuh00Jy4JF7J5acd5q+lG2LSJJqEmlPmTAbKukfSx70vIAymjR9uvTktxzby9
         g5HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIDlODQ6C6j6xwWK2DjZxN2ZeFOmz8hiyW0sdwJrBiDW//FcGJwHuIKrk3ygTET4jI8x1Vg/Aw+jY6aXvr@vger.kernel.org
X-Gm-Message-State: AOJu0YwSEAzTkJjNkZm5aCNH21IzqhFkYTOzlwfK2HmFR/d0PRbxfi2U
	irdlT4IKLC84EGG/YRlLWX7wVxZPXpSKKQDP2A8y4pti9Awa+2mvdRJeAVvPI4ieDebckWIBOn7
	WTcz4Ecb0ZsFMIzTLV4jWqv40AiY=
X-Google-Smtp-Source: AGHT+IEMiF+uKlvQ/HQhWuT4CtYTG4vdA+JApdic7PbkXTKHDRZTz4RHVK52hkMZzaSXYvagp+4k1Of+vLk6VUk4/4A=
X-Received: by 2002:a0c:f413:0:b0:6c1:75de:b9bd with SMTP id
 6a1803df08f44-6c33e6a73dbmr17367546d6.54.1724903951719; Wed, 28 Aug 2024
 20:59:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826203234.4079338-3-joannelkoong@gmail.com>
 <202408280419.yuu33o7t-lkp@intel.com> <CAJnrk1Y3piNWm3482N1QcasAmmUMYk1KkoO9TyupaJDBM8jW9A@mail.gmail.com>
In-Reply-To: <CAJnrk1Y3piNWm3482N1QcasAmmUMYk1KkoO9TyupaJDBM8jW9A@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 29 Aug 2024 11:58:33 +0800
Message-ID: <CALOAHbC9a-U+Gk53bxo1=X4nMQng8TSUWo7B=TZVN-f=Y4JeUg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] fuse: add default_request_timeout and
 max_request_timeout sysctls
To: Joanne Koong <joannelkoong@gmail.com>
Cc: kernel test robot <lkp@intel.com>, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	oe-kbuild-all@lists.linux.dev, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, kernel-team@meta.com, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 11:51=E2=80=AFPM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> On Tue, Aug 27, 2024 at 2:52=E2=80=AFPM kernel test robot <lkp@intel.com>=
 wrote:
> >
> > Hi Joanne,
> >
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on mszeredi-fuse/for-next]
> > [also build test ERROR on linus/master v6.11-rc5 next-20240827]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Joanne-Koong/fus=
e-add-optional-kernel-enforced-timeout-for-requests/20240827-043354
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.g=
it for-next
> > patch link:    https://lore.kernel.org/r/20240826203234.4079338-3-joann=
elkoong%40gmail.com
> > patch subject: [PATCH v5 2/2] fuse: add default_request_timeout and max=
_request_timeout sysctls
> > config: arc-randconfig-002-20240827 (https://download.01.org/0day-ci/ar=
chive/20240828/202408280419.yuu33o7t-lkp@intel.com/config)
> > compiler: arceb-elf-gcc (GCC) 13.2.0
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20240828/202408280419.yuu33o7t-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202408280419.yuu33o7t-l=
kp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> > >> fs/fuse/sysctl.c:30:5: error: redefinition of 'fuse_sysctl_register'
> >       30 | int fuse_sysctl_register(void)
> >          |     ^~~~~~~~~~~~~~~~~~~~
> >    In file included from fs/fuse/sysctl.c:9:
> >    fs/fuse/fuse_i.h:1495:19: note: previous definition of 'fuse_sysctl_=
register' with type 'int(void)'
> >     1495 | static inline int fuse_sysctl_register(void) { return 0; }
> >          |                   ^~~~~~~~~~~~~~~~~~~~
> > >> fs/fuse/sysctl.c:38:6: error: redefinition of 'fuse_sysctl_unregiste=
r'
> >       38 | void fuse_sysctl_unregister(void)
> >          |      ^~~~~~~~~~~~~~~~~~~~~~
> >    fs/fuse/fuse_i.h:1496:20: note: previous definition of 'fuse_sysctl_=
unregister' with type 'void(void)'
> >     1496 | static inline void fuse_sysctl_unregister(void) { return; }
> >          |                    ^~~~~~~~~~~~~~~~~~~~~~
> >
>
> I see. In the Makefile, the sysctl.o needs to be gated by CONFIG_SYSCTL
> eg
> fuse-$(CONFIG_SYSCTL) +=3D sysctl.o
>
> I'll wait a bit to see if there are more comments on this patchset
> before submitting v6.

Hello Joanne,

I noticed a change in behavior between versions v5 and v4 during my
hellofuse test.

- Setup:
  1. Set fs.fuse.default_request_timeout to 10.
  2. Start the hellofuse daemon, with FUSE mounted on /tmp/fuse/.
  3. Run `cat /tmp/fuse/hello` and kill it within 10 seconds to
trigger a Timer expired event.
  4. Run `cat /tmp/fuse/hello` again.

- v4:
  After the Timer expired event occurs, running `cat /tmp/fuse/hello`
again is successful.

- v5:
  Running `cat /tmp/fuse/hello` fails with the error: "Transport
endpoint is not connected."

I believe this behavior in v5 is unintended, correct?

--
Regards



Yafang

