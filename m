Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD05FDFA15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 03:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbfJVBXB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 21:23:01 -0400
Received: from mail-il1-f177.google.com ([209.85.166.177]:32899 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfJVBXB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 21:23:01 -0400
Received: by mail-il1-f177.google.com with SMTP id v2so13883895ilm.0;
        Mon, 21 Oct 2019 18:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0zUsDZVPfWx8cBMUDaOspw8Ge+4R1yeIceo7VAsjUM8=;
        b=r7nkDQxUFK2yVrhkKMA7g4sqUHqk0lthHTgqFmBQ37z4uBv55HjHjJrhlhYsQsjtWN
         fCAeSyZ+OfXJ8SC/0kI6/1yRR37A6GkBrAQOoay5k0ca4r+o5KQqSoUE36kT63Blh65j
         XjqX6RBvFnKBTvteF6VoXlaR8Aqguf7eFirHKHDmaGdkxIAdjpqIBfhwcNke45AnUqL3
         tM0ZxSDnOm5udvshHpxMcltBa4UX/+2bv+rQ8BTOAeVJyS9sySVBGvUKTh9OmAW0OV/i
         K9fNAJsN5D9bN5bBy7AeUmqHAC8oC1y1xeWIJH5WtDg9dWRI2BH93P2opD7EAsPJTtJf
         ORPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0zUsDZVPfWx8cBMUDaOspw8Ge+4R1yeIceo7VAsjUM8=;
        b=H4M7r/LMososvaE4/2H23G1IG7HdsvJjShV06MFNyYMecdZAtU10sAnu7ko4SQKwFA
         DkMG1w9ucaKqZjBc0NwD4h6RHg5Eb+RseF6qK5AhelFqHMCGAFzOvDrpHmHwJhh1hUWh
         2S65UlOvd+QGZrBmDaaF/Fk3fp9ZsLZ4iZ1Uj7Wi5ABVN9oin2Ox5Dkp7nMASMuwwQtv
         YVhAQ3IYCrMixE4AOVoCa81wP4Nq1DqeL93QkwgZucqL8RJBLJTU8C7a8A9Mi/qj1FMm
         VZw/mVqsrSSPcMO0us6XBEs8HfrkGnrSIUM9EGWLPjlrMNVxxUG/noRS62jw0o33BNQc
         3reg==
X-Gm-Message-State: APjAAAVlH5LOSeMrXpnV9mSy/PqRd978NRrbHHjxLxSz3wrNQm/C+3bv
        /wBh3PGJSVre6M/Qylz0AE9g/GrwWOAFNkkY/4P6f4rhzlA=
X-Google-Smtp-Source: APXvYqzxY973qFmkuPLhWooR4DQkI456R816bCyHFaox+8ndnC1EdyyBQouanY74beVkgfvtff5AomnpD/KxwXz318o=
X-Received: by 2002:a92:381c:: with SMTP id f28mr2579348ila.169.1571707380338;
 Mon, 21 Oct 2019 18:23:00 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 21 Oct 2019 20:22:48 -0500
Message-ID: <CAH2r5mtTodYZ9JcAnkEaK6Narc_tj4-d9d5=WAYDSf-qcFJFMg@mail.gmail.com>
Subject: Mysterious fs ioctl
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Trying to track down this failing ioctl (on a file opened O_DIRECT):

strace showed:

 ioctl(4, _IOC(_IOC_WRITE, 0x95, 0x2, 0x4), 0x7ffe5b491664) = -1
ENOTTY  (Inappropriate ioctl for device)

I could find ioctls for 0x94 but not 0x95 in kernel source ... any
idea what ioctl
   _IOC_WRITE, 0x95, 0x2, 0x4)
is?

Wanted to make sure cifs.ko wasn't missing handling some important
ioctl for O_DIRECT workloads ...



-- 
Thanks,

Steve
