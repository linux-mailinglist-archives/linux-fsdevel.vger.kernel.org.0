Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01F8FDF65E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 21:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbfJUT5g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 15:57:36 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:53346 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbfJUT5g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 15:57:36 -0400
Received: by mail-wm1-f45.google.com with SMTP id i16so14707721wmd.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2019 12:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=ln4etp2uH4ZzWM0cptVSLRxpJP6tM3kCrMXn8/hv0Z4=;
        b=Bjn8aSty3QwgZxNP9K/iuAeRgF+kox2ljfl+PwiqkW+924scJxKgeqcm0q3fOi8zrV
         nmOJsj9/fHEhP80E4Dpr52qUT33zt75gHIzL88YMhtWLELnmeEIO6K3dvtVnfDUmtQ/C
         w9NJ3UXJOIzm62ZM9oDzY8iYrqodTTVVZgnAarKOnFi+xf9wOhp639fG3z5XkWHwGVSu
         oZbdgVnXeTyzVo+7WgofDZHsZvHA7EMf4+GbCU1YP9FjwkaWnRB/KXSsEaq1sBeOrRaW
         u5OHxLGgURQthk++jHZmacc8p9/ezM+TfH1lZxP7Byh9OxAWicelJ82veU4mdDlkZP5D
         DFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ln4etp2uH4ZzWM0cptVSLRxpJP6tM3kCrMXn8/hv0Z4=;
        b=ETTKrKogFONVP/O/TEM4HKPtmAgBFQ2tXRFxNqpIAiMbGp/sfAIwNTJLrEkAabn+e1
         qtzw8z5B1AnSMLUHe0nxhHS1QhpNzoEb9r9FO9i8cm5Q+wpeg4TOzR/xBTJ+Zr9CXT/O
         l0O3AGrkvoDXRvZzFsQ5FUbw0fHx9DF+dc+Y+y0bjmOU33lov3PlGGR/vb2u0pfYOZAC
         b1wVdq7Emcm6U58rOXi0ErcE1uxgCjk9OZGXyCpFqj9K1fcAbW1H1wN8hYIIWf7VL0ne
         ETEzvhO7mQjk1AkakQzKMAefpTqaPYo52d4eHJhk1SR6DkUWO1AT7s3BwPZYEJPefT7J
         Pw/w==
X-Gm-Message-State: APjAAAUNhNiNy5s/AaQyAVN+0zH+lFx0Dm4y3FXgfSN2wk93h0I62sTZ
        nXY+I87mfZ5pgL4fRnkdL4ECSuXExZi6M/oFjkI2iVd/VsuTpA==
X-Google-Smtp-Source: APXvYqynjWB/oBeZMHrfturw7mL0Zf21lL/SAxjbH3lRcQ8Yz4QmNaD4RIs+kHVPRYJG2oCYUsOTN3ZBpHtOG3ewC6w=
X-Received: by 2002:a1c:f401:: with SMTP id z1mr20067676wma.66.1571687852489;
 Mon, 21 Oct 2019 12:57:32 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 21 Oct 2019 21:57:13 +0200
Message-ID: <CAJCQCtQ38W2r7Cuu5ieKRQizeKF0tf--3Z8yOJeeR+ZZ4S6CVQ@mail.gmail.com>
Subject: Is rename(2) atomic on FAT?
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

http://man7.org/linux/man-pages/man2/rename.2.html

Use case is atomically updating bootloader configuration on EFI System
partitions. Some bootloader implementations have configuration files
bigger than 512 bytes, which could possibly be torn on write. But I'm
also not sure what write order FAT uses.

1.
FAT32 file system is mounted at /boot/efi

2.
# echo "hello" > /boot/efi/tmp/test.txt
# mv /boot/efi/tmp/test.txt /boot/efi/EFI/fedora/

3.
When I strace the above mv command I get these lines:
ioctl(0, TCGETS, {B38400 opost isig icanon echo ...}) = 0
renameat2(AT_FDCWD, "/boot/efi/tmp/test.txt", AT_FDCWD,
"/boot/efi/EFI/fedora/", RENAME_NOREPLACE) = -1 EEXIST (File exists)
stat("/boot/efi/EFI/fedora/", {st_mode=S_IFDIR|0700, st_size=1024, ...}) = 0
renameat2(AT_FDCWD, "/boot/efi/tmp/test.txt", AT_FDCWD,
"/boot/efi/EFI/fedora/test.txt", RENAME_NOREPLACE) = 0
lseek(0, 0, SEEK_CUR)                   = -1 ESPIPE (Illegal seek)
close(0)

I can't tell from documentation if renameat2() with flag
RENAME_NOREPLACE is atomic, assuming the file doesn't exist at
destination.

4.
Do it again exactly as before, small change
# echo "hello" > /boot/efi/tmp/test.txt
# mv /boot/efi/tmp/test.txt /boot/efi/EFI/fedora/

5.
The strace shows fallback to rename()

ioctl(0, TCGETS, {B38400 opost isig icanon echo ...}) = 0
renameat2(AT_FDCWD, "/boot/efi/tmp/test.txt", AT_FDCWD,
"/boot/efi/EFI/fedora/", RENAME_NOREPLACE) = -1 EEXIST (File exists)
stat("/boot/efi/EFI/fedora/", {st_mode=S_IFDIR|0700, st_size=1024, ...}) = 0
renameat2(AT_FDCWD, "/boot/efi/tmp/test.txt", AT_FDCWD,
"/boot/efi/EFI/fedora/test.txt", RENAME_NOREPLACE) = -1 EEXIST (File
exists)
lstat("/boot/efi/tmp/test.txt", {st_mode=S_IFREG|0700, st_size=7, ...}) = 0
newfstatat(AT_FDCWD, "/boot/efi/EFI/fedora/test.txt",
{st_mode=S_IFREG|0700, st_size=6, ...}, AT_SYMLINK_NOFOLLOW) = 0
geteuid()                               = 0
rename("/boot/efi/tmp/test.txt", "/boot/efi/EFI/fedora/test.txt") = 0
lseek(0, 0, SEEK_CUR)                   = -1 ESPIPE (Illegal seek)
close(0)                                = 0


Per documentation that should be atomic. So the questions are, are
both atomic, or neither atomice, and if not what should be used to
ensure bootloader updates are atomic.

There are plausibly three kinds:

A. write a new file with file name that doesn't previously exist
B. write a new file with a new file name, then do a rename stomping on
the old one
C. overwrite an existing file

It seems C is risky. It probably isn't atomic and can't be made to be
atomic on FAT.


-- 
Chris Murphy
