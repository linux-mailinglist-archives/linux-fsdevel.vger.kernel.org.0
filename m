Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23C7C12F567
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 09:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgACI00 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 03:26:26 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41721 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgACI0Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 03:26:25 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so41636308wrw.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jan 2020 00:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=JJQxreXgv1LQSkDylotVWWUXSpXtwdDP4DeN74/aFW4=;
        b=ru0TEqmHgqHybOn1yZ0pPvLzqXVv6FeuzfxKvlzlJUZutqYp9XRpfmIad8ABHvK5Y6
         DUMDbxQywWmuYudgAm2Nta7EXxk8Io4D9gfyEMPYusxxiQDBQRheLxmxC+p3VPuqlmpm
         dJ4laEttAXz9bH91L9PKVs7cEDiXFLpryqDJqQWZD+QmTeTVYGq9z33vWoyMiNPHITT6
         GI/avzLdGU5I8xAk8MENmWlpoXf9Xuvh/uka0VaM9m5fX99DpWju7ppcAHA3ptvsNjED
         J8Owzh47mqbVFPGa8D2XqVnuQTwdKjox5RZB4/eDerKIFcwCOFUaAoobgoOHv7Emz3JN
         GlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=JJQxreXgv1LQSkDylotVWWUXSpXtwdDP4DeN74/aFW4=;
        b=WS6bFDMCpsxSMmQKQxh31zNwIP9U7FIpeP5d1j3I3x538LmUGO0gxWiZ66LnZvtA0F
         AXanoZCG7Pf/8TnmNMYAJOCO+7RvFADI2l9xLESwUcZ2myzvgVC8CyUXxjZ2/+K7taTw
         Nrc2caUiJCAm7/A1t3Ab+p0t5sJD1i3cKIL6/KPYfMbRP7445MW91geNLyizr0e07BpM
         kWW8yzKLpaLtkZGHm+7e2qKVX3HfFJvmZKcba7pYffkhsbSmd8qvJtQO7gSkWHybP1Zm
         SqDY1DmE2c9oVEf0abW6LRrSTfRccCPIT88TtU+VovI/UBk7HvwQQIfvYpKZUaDGKVqZ
         9UNg==
X-Gm-Message-State: APjAAAWqkFI9DXAIUclyxPYiy9NyrTG7CY/cKCxdrR3aoWpplzN+CLwl
        ZjndjK2OXL7GapjVSf+tniiNiXXjM7NjpFPcCgGQ2Q==
X-Google-Smtp-Source: APXvYqyMZ1MEKWuETaa8yoS05eQRFlQvgB8JRwmL5VHYJlNylOh5ap2GIa1OpH5+FAnSevfQjT8OM45Z1uDHYkuGaD4=
X-Received: by 2002:adf:9c8f:: with SMTP id d15mr87666317wre.390.1578039984080;
 Fri, 03 Jan 2020 00:26:24 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtS_7vjBnqeDsedBQJYuE_ap+Xo6D=MXY=rOxf66oJZkrA@mail.gmail.com>
 <4eca86cf-65c3-5aba-d0fd-466d779614e6@toxicpanda.com> <20191211155553.GP3929@twin.jikos.cz>
 <20191211155931.GQ3929@twin.jikos.cz> <CAJCQCtTH65e=nOxsmy-QYPqmsz9d2YciPqxUGUpdqHnXvXLY4A@mail.gmail.com>
In-Reply-To: <CAJCQCtTH65e=nOxsmy-QYPqmsz9d2YciPqxUGUpdqHnXvXLY4A@mail.gmail.com>
From:   Chris Murphy <chris@colorremedies.com>
Date:   Fri, 3 Jan 2020 01:26:08 -0700
Message-ID: <CAJCQCtTC_nJmBZmv2Vo0H-C9=ra=FuGwtYbPg41bF8VL5c9kPQ@mail.gmail.com>
Subject: Re: 5.5.0-0.rc1 hang, could be zstd compression related
To:     David Sterba <dsterba@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
        Chris Murphy <chris@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

BTW, I hit this with lzo too, so it's not zstd specific.

--
Chris Murphy
