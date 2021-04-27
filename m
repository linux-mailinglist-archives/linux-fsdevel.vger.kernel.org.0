Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E2C36BFE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 09:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbhD0HNX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 03:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhD0HNW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:13:22 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26F5C061574;
        Tue, 27 Apr 2021 00:12:38 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id v123so7574985ioe.10;
        Tue, 27 Apr 2021 00:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EL3CL+WsvHulIwsBMGDhvO/N9wHQZPJiiqaxaR8bBWg=;
        b=NkYZS+mnDZc+cHDnczHVs5Ka879/rge3YDVWU+n4CvURhKq7BJAhY+NWHFXnI7N9U5
         tKLsXbVC9P5hqqiGuzCY2MktwqtM9z8bRwk10mvvZxO0UgAhHaLuP29rXot8ufv1KHXf
         Ma5B6wcW73LpXXDWf6zZYZJmkHyHTUXXly73HXju27KujfeynDA4MLDBQCgcMkJWIoP4
         a/El+8GccSSUDt7yLj3lY428KEWoEJj2I2gYQOc346OamNzu/T04AlXaN0pfdMix2D6w
         7HFnWHA7dRkZU4zgL8/JF12T7R6wHgjqMEre5xYqd+GfpN055CVykmaLfbwtVN1c5vK4
         KGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EL3CL+WsvHulIwsBMGDhvO/N9wHQZPJiiqaxaR8bBWg=;
        b=Yg6+G/x39stzeaVL1uDlbGYp5lblSNg6ovybmbdRREYw4oTykaQ9WmHSVvfFUjmNVI
         4iZTsesY47gfIPFcxNZsoIZd7KADpBKvIO7erFs7hH8rcU+4xsNU4HLxEr72kN4mVlCw
         AT9Vx4/jheIXUdLD3yGZBh/dSblUm1FYCqONayj2rs9fHFg+RphOFgDu0GOfgVYFvbKQ
         f/qiItyCIBQ88ZxeeTkSdfgTR9CGEw2FUpFYk6F0brfySdP0jqoOojqrNIgUgvxZDq50
         XuV8muSYkh0dT1ka0wFG8vZ7cniwkXdXhBERfyoTajOML59qF/WVE4XhtlS7S8yvs13b
         59Ag==
X-Gm-Message-State: AOAM5338loMkqHIAC6rUV8n/iPsUFWzVA4DiB4IYF8fslOHLPfazhEdX
        rsUXE7HERQtipVGbxjrgaR/Hkj44AUq+NP3fybE=
X-Google-Smtp-Source: ABdhPJyUnJnoXTLE1vNL6xLCyeyagQZIdr6omhe60FvhVpvG1c7adv7+uwRm5IuWwaqhfzrEmrbVPRe6NK4g60mTRME=
X-Received: by 2002:a02:331b:: with SMTP id c27mr20071591jae.30.1619507558495;
 Tue, 27 Apr 2021 00:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210426184201.4177978-1-krisman@collabora.com> <20210426184201.4177978-12-krisman@collabora.com>
In-Reply-To: <20210426184201.4177978-12-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 27 Apr 2021 10:12:27 +0300
Message-ID: <CAOQ4uxjy4ZVrOY+HKikMspAK5QG3uHBPuZYCc8XCmji0jcG+LQ@mail.gmail.com>
Subject: Re: [PATCH RFC 11/15] fanotify: Introduce filesystem specific data record
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 26, 2021 at 9:43 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Allow a FS_ERROR_TYPE notification to send a filesystem provided blob
> back to userspace.  This is useful for filesystems who want to provide
> debug information for recovery tools.
>

Same comment as for FAN_EVENT_INFO_TYPE_LOCATION.
Can we leave this patch out of the discussion for now?

Thanks,
Amir.
