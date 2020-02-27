Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1D317291C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 21:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbgB0UA5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 15:00:57 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35979 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730080AbgB0UA5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 15:00:57 -0500
Received: by mail-lj1-f194.google.com with SMTP id r19so647723ljg.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2020 12:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oQC5XL/giSLKULG9Wvy81a1UMPlWPAivXJ99IMsyzPk=;
        b=HtiHDXlG0JR18/QlUwHqgHaaMmRjCfGt3buf0uUSKYgBFfx+4J7TF6G+NySGsdnlaH
         B4rOhvT6Ogi7oPnQxzuHB2lE5g+WnqVnP0+hnLDPqz7duPDZnUrbbdNewWrp/tgU8Cat
         LnVR7BaEsyOiMmriMtKa0e+wMcEpK3a2vIhlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oQC5XL/giSLKULG9Wvy81a1UMPlWPAivXJ99IMsyzPk=;
        b=n0gq6OBQPzu3Ddmjtl3XzdnGRyqwvG5UXIq31UWV/dz/dgAJU3/zpXlXIdTtF0p8HO
         RitRgxortFsD4ypcrzS0SDRd9IlFJYVk6NvdgVLpFy+jqA6CbGRQTFydX9hbKQTXSuJk
         I2Hlw0eIdl25bBE47kOy1a8QoX421DzJEDAJzqdjDjzcWl7G23vtf2nB9IAdTEY9WaFg
         JSANE1AiPubYeszJr9Fua2mYZez7hRclVQOFIQeC1YIqw7h8FpuwfT1yuWxq2AQ0aXKh
         Qs+CYiGQYwirueQw93QqkBf6pfxIZOIYpkjvC2cySNnZzSy8mm6xrrtiITE7qMj48Cyq
         +VHA==
X-Gm-Message-State: ANhLgQ0r/KW0CQkZfu2Eb7uZ+ImtODrvqR/HJE36Kjb3EUI6e0e1i6sf
        v2/bIZmVEtcE1NJnC3lRqAglptCySGk=
X-Google-Smtp-Source: ADFU+vsKOOh85MAkRJwkgum7SHbci5UpncAamAKm2aph4y7mypX/dT4KtYeDGtRJLNK5mfWj4qXJrw==
X-Received: by 2002:a2e:2c0f:: with SMTP id s15mr432509ljs.81.1582833654755;
        Thu, 27 Feb 2020 12:00:54 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id u5sm3585662ljl.97.2020.02.27.12.00.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 12:00:53 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id r14so343179lfm.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2020 12:00:53 -0800 (PST)
X-Received: by 2002:a19:c106:: with SMTP id r6mr603675lff.10.1582833653416;
 Thu, 27 Feb 2020 12:00:53 -0800 (PST)
MIME-Version: 1.0
References: <20200223011154.GY23230@ZenIV.linux.org.uk> <20200223011626.4103706-1-viro@ZenIV.linux.org.uk>
 <20200223011626.4103706-2-viro@ZenIV.linux.org.uk> <CAHk-=wjE0ey=qg2-5+OHg4kVub4x3XLnatcZj5KfU03dd8kZ0A@mail.gmail.com>
 <20200227194312.GD23230@ZenIV.linux.org.uk>
In-Reply-To: <20200227194312.GD23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Feb 2020 12:00:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wje=1xYx0N6ERSZfR8TgjSOY_PA2DSCGbE40GNwOeeF4w@mail.gmail.com>
Message-ID: <CAHk-=wje=1xYx0N6ERSZfR8TgjSOY_PA2DSCGbE40GNwOeeF4w@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 02/34] fix automount/automount race properly
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 27, 2020 at 11:43 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Umm...  A bit of reordering in the beginning eliminates discard1, suggesting
> s/discard2/discard_locked/...  Incremental would be

Ack, thanks.

          Linus
