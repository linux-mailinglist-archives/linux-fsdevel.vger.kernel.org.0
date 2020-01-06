Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09B5F1318E1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2020 20:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgAFTqi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Mon, 6 Jan 2020 14:46:38 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36250 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgAFTqi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jan 2020 14:46:38 -0500
Received: from localhost (unknown [IPv6:2610:98:8005::147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C2936291A19;
        Mon,  6 Jan 2020 19:46:36 +0000 (GMT)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v9 10/13] exfat: add nls operations
Organization: Collabora
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
        <CGME20200102082407epcas1p4cf10cd3d0ca2903707ab01b1cc523a05@epcas1p4.samsung.com>
        <20200102082036.29643-11-namjae.jeon@samsung.com>
        <20200105165115.37dyrcwtgf6zgc6r@pali>
Date:   Mon, 06 Jan 2020 14:46:33 -0500
In-Reply-To: <20200105165115.37dyrcwtgf6zgc6r@pali> ("Pali =?utf-8?Q?Roh?=
 =?utf-8?Q?=C3=A1r=22's?= message of
        "Sun, 5 Jan 2020 17:51:15 +0100")
Message-ID: <85woa4jrl2.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pali Rohár <pali.rohar@gmail.com> writes:

> What do you think what should kernel's exfat driver do in this case?
>
> To prevent such thing we need to use some kind of Unicode normalization
> form here.
>
> CCing Gabriel as he was implementing some Unicode normalization for ext4
> driver and maybe should bring some light to new exfat driver too.

We have an in-kernel implementation of the canonical decomposition
normalization (NFD) in fs/unicode, which is what we use for f2fs and
ext4.  It is heated argument what is the best form for filesystem usage,
and from what I researched, every proprietary filesystem does a
different (and crazy in their unique way) thing.

For exfat, even though the specification is quite liberal, I think the
reasonable answer is to follow closely whatever behavior the Windows
implementation has, whether it does normalization at all or not. Even if
it is just an in-memory format used internally for lookups, assuming a
different format or treating differently invalid file names can result
in awkward results in a filesystem created on another operating system,
like filename collisions or false misses in lookups.

-- 
Gabriel Krisman Bertazi
