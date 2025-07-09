Return-Path: <linux-fsdevel+bounces-54380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72214AFF039
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 19:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4941895C4F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 17:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED7B23F41A;
	Wed,  9 Jul 2025 17:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hq/EJK38"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1993B23CEE5;
	Wed,  9 Jul 2025 17:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752083600; cv=none; b=Mx58a8p5DYnDCR1XX6b5ZHXZxAJpjM/mt6+KPu/3aXjqIRqRvFDxTeaqdooITRsrDdGrRmNT48sqpPwRmk0UMZNiqCCldHK5mM2BLILL8hGS7AD6tEoT4+gthJUwR2Q3yGUKvyksn7H1TyxdPFQtd01anmSezz//x+sajRx1OHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752083600; c=relaxed/simple;
	bh=cZHhkkKoQxfdiwhShrVfsLlYDQveqtG/P5pJwSmN728=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7sn5h8kAZ9R7yZ4bmWibN3RS84GRyXIzmXi7h67lfkZPt/OZAohNOBljyejWumrSRQNQzqCLJUwrL6qy3V78+gmgxxloWCU2qdxHyQ40qys933s+bumtofz/PJihp8+e7K1mmx301WHyD6FXvhy6i1XfJkbvMMXZ5PDpJ6qfl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hq/EJK38; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a752944794so1885411cf.3;
        Wed, 09 Jul 2025 10:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752083597; x=1752688397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chdWduo0xuyTSA7hGxJ9MzGIosMpOq6sLEcgGmEUqho=;
        b=Hq/EJK38qyfH9u4qt6mYJ2LCGwOPMFZ6kQGrLVllKpzYqJBmWeoHzwj9Am3cIopW7g
         QA+WRp1itL+lODt2KSOMzUX7mtQmYowjdBzMlgvYTrCFMs04VvPNyMwUipVrPfMghlbM
         hR6RNK3MB1tSmQ9BZeJKp9wuYmP8VD/nTlBWPcpPgBVT7o+84i/GZGy8U8fPB+RBtV3k
         1BENpXdUFABHy654344a1SeMis9mNMX8+XU5Fe4IQJz3FDRK7fj24Q9jypTOAH2fa80C
         5VlMmKYl3LZy/DaZczm9X+PTrcrlz/j2RwTFXIawY7nKpOE+3MRUxXu6w9izDXc4b7x8
         Es9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752083597; x=1752688397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chdWduo0xuyTSA7hGxJ9MzGIosMpOq6sLEcgGmEUqho=;
        b=wCBCfBbQdoFELVLGfD5oJ4r2hqplsvPFKvbjrCFqRJhIs9+bOmEEUT+gcul6mEwvPW
         27dxhDs7K8tw2WLomZuhqX4sqsRj+SdDgUZSKAegYF6vm4m5VS9TYWbxoJo9iVDJf18J
         Of0vZZ5eeN8jIpIwWnlzIvK2p4k6CiKoDYD2QJyUJRaJYTZ9wFm2GkZK1x+bnRLcXRF0
         bkhE06qkc1ofyWm6iXTjiy6sj4kOZAFmSp0HomFz++ZwWFITWW2pJZK0v0vcFS/zAaYX
         xd+4gvokvS7gmC13x2MzgsIoPn4NoXwZcWzChjoIcqAJII/3Vfyv5NtnZn6i6Lwn+kne
         k/Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUFKyFV5a8p3lLpVSj4sT3cbDUtbmpw7A8UMyGhmDWjR++ZIkcyo2En1hsRmmRvwW8/kbpbUY6/1MzuZluF9A==@vger.kernel.org, AJvYcCVQzdwAmg0GJ3GxG0dWV5cyLicu7dLOIgmHCHUOdknDlVBsIScWp2k48bReVuIfc3cSvxoead1KpDoS@vger.kernel.org, AJvYcCVxKH3qOMjeMwjEecuUW4L7DWy1gG2tDG04nLrp85zztLoph0WsM0nr+l+ZN7xuwkih1NaZsevGN2D/Gw==@vger.kernel.org, AJvYcCXxjwYeHzU/neM7057uGVHb8oeGHOsrT3u712lbzmEaFaIbeWI8yNUfSk0B6YEh+ArxWp+PZfydfcBv@vger.kernel.org
X-Gm-Message-State: AOJu0YzIQ9ChFnrmexfbxzmAyOPijAwxsxNsK0R40VaTpZIPoTEsEaML
	lPpl/QSPAcwb0qB9JZclp6hr/Vmi8udlxSprDcmW72N0vd0o2LXAPPfxbeo0Xi4irgTEdApa7+f
	Ew+aMd4fzR4oiPcM/kQn7U8lrw3fVP+U=
X-Gm-Gg: ASbGncsnVjJGug+GeEXiXXlfIPhASOiyrbYXfbjRAuwxVlgs/xtTgrLkI4Ut1tCg6cI
	udldWWuTRt1xe8l1awGqcRfWHeDWECQ1V5xx+pCmWyY3gIPZ3+LVrET/Zab7PKIGnHLSkM4nabe
	L2oRaBp/53WiRb2luaKdBYVvFewI/IPzNbnML/ZQvz5CE=
X-Google-Smtp-Source: AGHT+IGkscAnB4QMpdxgxygggoSbOo5Dbwl3HdhbBvnA4GtflSqoDUUggCyQ2Ui8pU012OkwACWTD3Kn2ubKI0WOy04=
X-Received: by 2002:ac8:5756:0:b0:472:1d98:c6df with SMTP id
 d75a77b69052e-4a9ded485d6mr51084801cf.52.1752083596844; Wed, 09 Jul 2025
 10:53:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708135132.3347932-2-hch@lst.de> <202507091656.dMTKUTBY-lkp@intel.com>
In-Reply-To: <202507091656.dMTKUTBY-lkp@intel.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 9 Jul 2025 10:53:06 -0700
X-Gm-Features: Ac12FXzmT0rdR0DNiEi-ua93g95fceSTbfERwsHSYCOm31aBpdD657n_w-OLo_M
Message-ID: <CAJnrk1ajT+OdZiSPOQ5Bv1HdtWqpjz773t8Q5=Om7zcroVXaGg@mail.gmail.com>
Subject: Re: [PATCH 01/14] iomap: header diet
To: kernel test robot <lkp@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>, oe-kbuild-all@lists.linux.dev, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 2:10=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Christoph,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on brauner-vfs/vfs.all]
> [also build test ERROR on xfs-linux/for-next gfs2/for-next linus/master v=
6.16-rc5 next-20250708]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-Hellwig/=
iomap-pass-more-arguments-using-the-iomap-writeback-context/20250708-225155
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.a=
ll
> patch link:    https://lore.kernel.org/r/20250708135132.3347932-2-hch%40l=
st.de
> patch subject: [PATCH 01/14] iomap: header diet
> config: arc-randconfig-001-20250709 (https://download.01.org/0day-ci/arch=
ive/20250709/202507091656.dMTKUTBY-lkp@intel.com/config)
> compiler: arc-linux-gcc (GCC) 8.5.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250709/202507091656.dMTKUTBY-lkp@intel.com/reproduce)
>

Adding #include <linux/writeback.h> and #include <linux/swap.h> (for
folio_mark_accessed()) back to buffered-io.c fixes it for this config.

