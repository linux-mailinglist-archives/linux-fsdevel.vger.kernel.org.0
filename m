Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C153FAC39
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 16:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbhH2O0v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Aug 2021 10:26:51 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:44551 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbhH2O0u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Aug 2021 10:26:50 -0400
Date:   Sun, 29 Aug 2021 14:25:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1630247126;
        bh=mmvKLlJPwn9FE9InvpVbvMOjd3dA4r2TNeQ84ldrtFI=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=CvYtHRSJPLZiFuRT76fuio4eRcgjMXkEd4Fa+lPpSRXCZ/kRuvkI5Q8UeW/VxTtdC
         MAcEFqObDvcAHp7O8BOFm7202QgZORZpocJxuhm0qc+9YsYIJtFiUl2/lwe1mhS1xg
         5On5+IOEWRvvwlYN85cVSP3s6+WddHW8nU+1Dcbo=
To:     hirofumi@mail.parknet.co.jp
From:   "Caleb D.S. Brzezinski" <calebdsb@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Caleb D.S. Brzezinski" <calebdsb@protonmail.com>
Reply-To: "Caleb D.S. Brzezinski" <calebdsb@protonmail.com>
Subject: [PATCH 0/3] fat: add a cache for msdos_format_name()
Message-ID: <20210829142459.56081-1-calebdsb@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

This patch series adds a cache for the formatted names created by
msdos_format_name(). In my testing, it resulted in approximately a 0.2 ms
decrease in kernel time for listing a small directory.

The overhead is in memory, but each entry is only 25 bytes plus
sizeof(struct hlist_node), and the cache also actively collects
infrequently used nodes, keeping overall memory usage low.

Caleb D.S. Brzezinski (3):
  fat: define functions and data structures for a formatted name cache
  fat: add the msdos_format_name() filename cache
  fat: add hash machinery to relevant filesystem operations

 fs/fat/namei_msdos.c | 140 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)


base-commit: 85a90500f9a1717c4e142ce92e6c1cb1a339ec78
--=20
2.32.0


