Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618D739668D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 May 2021 19:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbhEaRKu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 May 2021 13:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbhEaRHL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 May 2021 13:07:11 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941D9C035433
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 May 2021 08:17:45 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id v13so4572819ilh.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 May 2021 08:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=qwRRLkLoXNDIQdovU1zPLyrg6JIvWrQf/bakSwhNMqE=;
        b=DKdSajSyW09omZdU9de7mzdEKympONwXv6cmndp3hotS2j1qSlJa2RgAlW1I4jlHlb
         EGtnCNJrI/m0riKdDSieJSZkAFKDGxH/rPSS5lkxM+vr8/NYAOnBY23KmgV22vkzVsWX
         FMq2OnGAXOmAiAqegF0KIkJnMzNRVP3n3z0ZquCFQcvNlf1N+hcXiK/C4ZN+Ys+pu0e/
         NNWb7Xv7nckjxVM1pX7fGZFNjKrJZJrrdSYtF5iUiX9OekK0FWBYO2liJLErRfWnM6Fg
         T3AHC0CGjA397574PGjTqRtr+f+46/s31B3j3sXTOdT3LIl+X5JeRI6tY64oI2QK873z
         VFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qwRRLkLoXNDIQdovU1zPLyrg6JIvWrQf/bakSwhNMqE=;
        b=RsLUvyeAdYqLvmGVBm4IbVVECiH04hqKjOPJF7+H2vPq7UdC7TIQ+d17SRsZqWMwB7
         XWbhQ57MnSOYX+d0LOV88b0EGn4kFiBfj0faVHMknYyVNalw/raDRkjWMq5TttCgjop/
         /Dh8BmbvlM5VcQ7V9sJJOCE//bfF2WWsJrz6LJ/wbWMKzO8/4kNsUTlV+8cmV4TA9x44
         hZNhQ9h/LaLrv8RawzUWGsOlmE41wpR0eNb671OTA56ELd+4vuTuwbdAgNXG/pVArI39
         1/CmUWhD624IThm+2/rzqqApMIUK6xJw9olHclvWvKI2V2DdjKYLpUhsgu1F6Hff1jua
         OLyQ==
X-Gm-Message-State: AOAM5315QZKBMVV1DiLEeYABCb5shOUwS9EU/A1pWkZMeZOHpt05DYbz
        BtxYmO67oeRYCOkfy+aX9pQvroI+0vhwH70AC96sG4A1kxjHAQ==
X-Google-Smtp-Source: ABdhPJwrBpCt7EeXdY82h5u5MNSQBUI3oshWw3XAR9XYTE41rggKg17S0APqOuRWpl6+U57FzZ83tcP3YuXcX9HcklI=
X-Received: by 2002:a05:6e02:e8d:: with SMTP id t13mr3964703ilj.189.1622474265000;
 Mon, 31 May 2021 08:17:45 -0700 (PDT)
MIME-Version: 1.0
From:   tianyu zhou <tyjoe.linux@gmail.com>
Date:   Mon, 31 May 2021 23:17:34 +0800
Message-ID: <CAM6ytZqioJ91r8Ax7KpNzkF0Ai9DSoU0oVt0VOT2Svv=zSGvRA@mail.gmail.com>
Subject: Missing check for CAP_SYS_ADMIN before calling reconfigure_super()
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, there exists a check for CAP_SYS_ADMIN in do_remount(),
do_umount() and vfs_fsconfig_locked() before they finally call
reconfigure_super().

---------------------
// fs/namespace.c
static int do_umount(struct mount *mnt, int flags)
{
        ...
        if (!ns_capable(sb->s_user_ns, CAP_SYS_ADMIN))
            return -EPERM;
        return do_umount_root(sb);
        ...
}

static int do_umount_root(struct super_block *sb)
{
                ...
                ret = reconfigure_super(fc);
                ...
}
---------------------

However, for function do_emergency_remount_callback(), vfs_get_super()
and reconfigure_single() in fs/super.c, there is no such check for
CAP_SYS_ADMIN before calling reconfigure_super(), neither do their
callers.

Is this a missing check bug which may break the protection for superblock?

Thanks!

Best regards,
Tianyu
