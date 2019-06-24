Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1F4C5002D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 05:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfFXDW4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Jun 2019 23:22:56 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:40907 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfFXDWz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Jun 2019 23:22:55 -0400
Received: by mail-pf1-f175.google.com with SMTP id p184so6662196pfp.7;
        Sun, 23 Jun 2019 20:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=3lQoXJ1dymJIS6Y/FsyTEm2UVd7fXkrqHDzZRX1Rv60=;
        b=S8KUfqKQMkHor2arXMcbkxcoIxFB3ToewWpVaZzvCNeJlXcLTpzbT1nlJkFoKO2f5Q
         P3B6dkRpKb/TiO3f2PBAVohE7TJj6/QHfCHCBtfu/SWVj//vFhuwd27uNB9+XmnRVgAM
         9tjRy8QZC1h59160ttUcVqHvXR9KHWWr+lppHTNEegGHpxqTwbckb23RQWtfsLlkTDee
         G/6/a3cXS7kJiF+ER8e7xGdtOwINA7VCZhRYPiAsF9R3OPf2vtjpE3fVmF40iSwbfRV+
         Vn30t8RTXuh283L2I3ARNpE7tIKYwYBz8QFM3YcEz2/D5xy0oWVX4L0mfAJO8OTVBI0A
         yt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3lQoXJ1dymJIS6Y/FsyTEm2UVd7fXkrqHDzZRX1Rv60=;
        b=m2wdq3jCLbICCdBm5ypqDMN1RbOU/XgBBR6YEN+B61VDtr3jEp5+wnKVrgfEPuDL6c
         iLoXkS8lK8s037hR0SRdH8Ja9L/xezNDL1t3PweepqizCTRRmxUbVkwj0DrajFqLA+vB
         hZ9pGAOKIyiTnd+JjxzD7IP/LAtSrC/7CyrOw2hmDD6vWJ6hcx5y3XdhWZuq4D2jemFS
         besQiQpfFYGZRNyhdxhQm14reu+t4DBz6YNv5U9HjM5jq2e5lVh3FS0/Ggapacyx0Vt/
         e+4gZ/DUxtb+bzp1Znk6XjTG3gdK6NPMP/0wPiRYqAyD98sWDgOI/UDcgvZb9Zt40pmM
         Og8w==
X-Gm-Message-State: APjAAAVSd/vDKvkru8qk+Jj0ylNHr3OjPpcRJrq4FY7V0rPVS0j0vhTJ
        GzWW1NfSBcGnJ+5brGPrFDQg0Pw9qT68L5doa5qhp/Ys
X-Google-Smtp-Source: APXvYqyS4j3doQw4LGxfPJZzgFSkahgRxCPV+SvHbFoybnlz1Fq5vas82BPI0x65UNx9Gz4aYq/Lmb+1EuyumsjHMbw=
X-Received: by 2002:a63:81c6:: with SMTP id t189mr18456341pgd.15.1561346574585;
 Sun, 23 Jun 2019 20:22:54 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 23 Jun 2019 22:22:43 -0500
Message-ID: <CAH2r5mv+oqGxZRkV_ROqdauNW0CYJ7X9uJCk+uYmercJ4De41w@mail.gmail.com>
Subject: xfstest 531 and unlink of open file
To:     samba-technical <samba-technical@lists.samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Xioli created a fairly simple unlink test failure reproducer loosely
related to xfstest 531 (see
https://bugzilla.kernel.org/show_bug.cgi?id=203271) which unlinks an
open file then tries to create a file with the same name before
closing the first file (which fails over SMB3/SMB3.11 mounts with
STATUS_DELETE_PENDING).

Presumably we could work around this by a "silly-rename" trick.
During delete we set delete on close for the file, then close it but
presumably we could check first if the file is open by another local
process and if so try to rename it?

Ideas?

-- 
Thanks,

Steve
