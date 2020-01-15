Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD1BD13CDCD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 21:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbgAOUKz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 15:10:55 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35445 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729829AbgAOUKx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 15:10:53 -0500
Received: by mail-lj1-f195.google.com with SMTP id j1so19965672lja.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2020 12:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V37Vo/FBhU5kltccCSOcOaOV/u6sTU75u7lgAerRHWk=;
        b=OrYEwmU6lkXsGZWCHNNhtVtpsE6fs3wEj0m6dC3WrtWTeidQt6E9H+zSvKowaPh1ec
         ugRczy3F4djq+5tAM9KSePUrrGy8RTZj+3Nsfw0drc5nlDq0wGY+b9DTqALVC2112QUl
         PU4s1hiA953qkOxsAyvqyWsjNb5gpuGJJ8PeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V37Vo/FBhU5kltccCSOcOaOV/u6sTU75u7lgAerRHWk=;
        b=F5QIVsvqru+clVOPsGUtAsfWnDoCfZeb2KntuF1yY443IIWBpuQNOuFPsBaZ36XMRs
         51dFvRBX7F+uY1aIBV1AigLLa9deTYMVqEi2V1LKWYg5QKFi852ZiEEVa22nqeYn5doL
         iiBciHijaI/8n8P3aBRTi8+F7HI8XIT71jONwFR8iIHSqMNP7RMGHRQuwxAIyzvOqcm4
         27/J2kMxwuOf3G9mM0UcKjwiqeyM6gRHSjJ8A8SOyZM+cTHGG255mNZYmpTY4phwW7FV
         mMMk2PqZ4j56Q7syg6yfS+CvLccqsjQyNTcwYp2fNKqO/UoZDk4BxI3+EuS5YNvCchZg
         CENQ==
X-Gm-Message-State: APjAAAXl3e9Q/XFlcE63ByndVLhiQC180vTNL9MllvV8BX+r+vMF29re
        42T3femcpAQN/AGNmEWBqUn+GvjtCPQ=
X-Google-Smtp-Source: APXvYqxOQa4C/bjNt45/+Od7jvC/l61YJYDdPazcAkykfMZ/3gnEXUdNYhkfEux7fwoHJI2j8E4qYw==
X-Received: by 2002:a2e:9e55:: with SMTP id g21mr65321ljk.245.1579119051120;
        Wed, 15 Jan 2020 12:10:51 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id k12sm9432708lfc.33.2020.01.15.12.10.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 12:10:49 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id z22so20001786ljg.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2020 12:10:48 -0800 (PST)
X-Received: by 2002:a2e:990e:: with SMTP id v14mr74215lji.23.1579119048131;
 Wed, 15 Jan 2020 12:10:48 -0800 (PST)
MIME-Version: 1.0
References: <157909503552.20155.3030058841911628518.stgit@warthog.procyon.org.uk>
In-Reply-To: <157909503552.20155.3030058841911628518.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Jan 2020 12:10:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjrrOgznCy3yUmcmQY1z_7vXVr6GbvKiy8cLvWbxpmzcw@mail.gmail.com>
Message-ID: <CAHk-=wjrrOgznCy3yUmcmQY1z_7vXVr6GbvKiy8cLvWbxpmzcw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/14] pipe: Keyrings, Block and USB notifications
 [ver #3]
To:     David Howells <dhowells@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So I no longer hate the implementation, but I do want to see the
actual user space users come out of the woodwork and try this out for
their use cases.

I'd hate to see a new event queue interface that people then can't
really use due to it not fulfilling their needs, or can't use for some
other reason.

We've had a fair number of kernel interfaces that ended up not being
used all that much, but had one or two minor users and ended up being
nasty long-term maintenance issues.. I don't want this to become yet
another such one.

                 Linus
