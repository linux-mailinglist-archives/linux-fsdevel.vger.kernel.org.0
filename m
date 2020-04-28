Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051F01BB3F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 04:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgD1C0V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 22:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbgD1C0U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 22:26:20 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69070C03C1A8;
        Mon, 27 Apr 2020 19:26:19 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k6so21244245iob.3;
        Mon, 27 Apr 2020 19:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FMvwtGQZLq1L/lrozASgEEmqeKN2vH77hyNyQPJ8S5w=;
        b=WMtwLvKUh2T8bj7twbhvT28/7Rm//2fQwrABXEyjG0ghPG8gKkw2RslGTLbcbm5sW1
         +R07Dn7q1ToS0ZkSZc5/zNb7qy1rC+d2PNnh6tDk9lk5KUmWWRyshQACmhSfEY01+aqT
         tLEYuVhDd+hVu9xOXRL7ZUfoRROPo0Yl4T6HuLJ+Ire0K7gTa8YNkIL3c1KB12581qcG
         qGS12oYhvz7RynAu2UbjAYGXXv4un4ZHTDNaycp69bXHHYNNA1RGBQFmoIy1Yj7+yndZ
         LXY4X7WOSzTuozb3uSjCGcvbiNUgkZaXuQhyxKecSHpoW8Gb06Fc5U2tlCJIyekGw9Ac
         xEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FMvwtGQZLq1L/lrozASgEEmqeKN2vH77hyNyQPJ8S5w=;
        b=qnTJn8BWufSdExZ3IoNjggoGPajxBbrlvYv8DgaAQXh/Zs9zDYR1wKkIsasdmod2zq
         QyIWDeB8w4D5zIry4LCK3nilhRee5u6TYQdRCFhoxChI7e+u8QMVRjtGeVwIKglNI1M5
         JDucIYNiJIkK6biUelwFRzL3RBMlMSrdcIsprwR7bvyyZH3FhASmSTlYABvvWBtqjtud
         1wpSVFYtJOShNUgIandZrKW1B9JjFrm5EirERX6mgh8l0OZLrje3WcXHaBIyLN3V4NWG
         wvybvSGBX9l7VjkRz7eGJpLKlbLNqNKfgs0BjgtJIX2I4eFg6E9domKvMrlOFjUwtYAq
         UvwA==
X-Gm-Message-State: AGi0Pubs8DnutmVt/wXNkcVW2mdbJEgGSbXwRr6IlkdwMbsBgftcuv3Q
        KrM48THH1WBnBY9Cw494JwAPGRr9inroiB7DQDA3skc9
X-Google-Smtp-Source: APiQypJa4Bmq8SUVveALMu0EuXsQBvvkLvIQ2EOIFIl2XTHp5c2ju7RDRhCFNDct2aKaHTWVZs7k0pzDtPkZ59TS7C4=
X-Received: by 2002:a5e:a90a:: with SMTP id c10mr24021886iod.64.1588040778785;
 Mon, 27 Apr 2020 19:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200427181957.1606257-1-hch@lst.de> <20200427181957.1606257-10-hch@lst.de>
In-Reply-To: <20200427181957.1606257-10-hch@lst.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 28 Apr 2020 05:26:07 +0300
Message-ID: <CAOQ4uxj8=C887JUSEMDZtyUz+m9muVUd1Z4o64RX1pH8LJYrkw@mail.gmail.com>
Subject: Re: [PATCH 09/11] fs: handle FIEMAP_FLAG_SYNC in fiemap_prep
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ext4 <linux-ext4@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 27, 2020 at 9:20 PM Christoph Hellwig <hch@lst.de> wrote:
>
> By moving FIEMAP_FLAG_SYNC handling to fiemap_prep we ensure it is
> handled once instead of duplicated, but can still be done under fs locks,
> like xfs/iomap intended with its duplicate handling.  Also make sure the
> error value of filemap_write_and_wait is propagated to user space.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Nice!

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks for fixing this,
Amir.
