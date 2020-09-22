Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A488027439B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 15:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgIVN47 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 09:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgIVN47 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:56:59 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89478C061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2020 06:56:59 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id v5so5504342uau.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2020 06:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0la+NjqOspuYNFekbQHmZdYeJ/vAjkgTC2efPzMN2FI=;
        b=oZkDdTCnD0YA6UlQCZOdKL1o6Snt49DpVTtDbTUtiNUB2ibOzVFtkhfZYws5Q+uTyj
         wXwLH8g7BAQg9kiy9OdkW2tr+4O1AoenLldp1JfhnJaMSy84vDWemPA3wM7uKuv0J6M5
         wy7O2ia4ODWZEjj3lbSv67qtxbjt4ChMTVhU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0la+NjqOspuYNFekbQHmZdYeJ/vAjkgTC2efPzMN2FI=;
        b=TuF3V0sStEnIC/RBjVWGGBoYz3F5F624WLVtavCq1b9MnRGPJSjuhM1Os05kbyA1R4
         MjeQXPNvGIBUCPZ7sxJUNeoOk0wTdFoEu2OCgRCao1+t+0FOBgHZqTLPbkIFr5eS8jEH
         44PWS4N/WMSJU98WEd1Zb+xom/9u5fUbRZ2JjC/XCCkoaU+D88GbJWuoQvkVwpBXK9cP
         A0z9AeRtE0y4chaSY33aSUhYovGBqb7FHDeoW399MWaq7/syXTCjv3YcQlREPVdwv7sp
         k3HOOmsokkJOBWjXbZJOSA2RJFPOkI6LEl6UqwzMkhIH5tw+LX+UpRxxkU3hUkQHVAiQ
         6P/w==
X-Gm-Message-State: AOAM531z4TSqhtr5BJ+yBTpmhpCe7wWWhj8MtHJ4eFma4INMB267RopC
        iiZtsWdhdY6krXq67yhTkPqWxi5P3VOlVsnZqKi+YA==
X-Google-Smtp-Source: ABdhPJx92MkTzhFs4x7X3E6tPCJGH1Fl6XNrTKUq1ToFvbJQKVAZRoz9N3FWn+9mYnR/nJkn/Oj9IKETHh3YU3Jssm8=
X-Received: by 2002:ab0:ef:: with SMTP id 102mr3037429uaj.142.1600783018711;
 Tue, 22 Sep 2020 06:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200916161737.38028-1-vgoyal@redhat.com> <20200916161737.38028-5-vgoyal@redhat.com>
In-Reply-To: <20200916161737.38028-5-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 22 Sep 2020 15:56:47 +0200
Message-ID: <CAJfpegsncAteUfTAHAttwyVQmhGoK7FCeO_z+xcB_4QkYZEzsQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] fuse: Kill suid/sgid using ATTR_MODE if it is not truncate
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 6:18 PM Vivek Goyal <vgoyal@redhat.com> wrote:

> But if this is non-truncate setattr then server will not kill suid/sgid.
> So continue to send ATTR_MODE to kill suid/sgid for non-truncate setattr,
> even if ->handle_killpriv_v2 is enabled.

Sending ATTR_MODE doesn't make sense, since that is racy.   The
refresh-recalculate makes the race window narrower, but it doesn't
eliminate it.

I think I suggested sending write synchronously if suid/sgid/caps are
set.  Do you see a problem with this?

Does this affect anything other than cached writes?

Thanks,
Miklos
