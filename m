Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19BEBCB102
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2019 23:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732429AbfJCVWw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Oct 2019 17:22:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33263 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbfJCVWv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Oct 2019 17:22:51 -0400
Received: by mail-lj1-f194.google.com with SMTP id a22so4370127ljd.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2019 14:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mMXUawk779Rg0n7VhPYVUvheDt/wHtDxTM0M49SF5fA=;
        b=aZ7lBYY4rKVPH8dxmUG7mt7rDQdVdok66Rw4NZYoRg3NtYbxPIacz5XYEdobLqtBuO
         8VbzJjwcH/DnujSAq6CeR6sCPivqUr6/V+s/zHZCF9D41Mo2p3OxjjrfIrWW1csW/Zp4
         z2jSBIEgN8eAvUq7rq+racF2NZwVxV228QsXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mMXUawk779Rg0n7VhPYVUvheDt/wHtDxTM0M49SF5fA=;
        b=rXQ8CnEbhw4aDRdOCU9jB9pCut6vsUei6V9immo9J3K6LtIPCV7h8ooLQZK+3NnAxd
         Vzxa5+YJt//+RwuFPLkCXZ9Fj6bzeKI9SgB618dW7j4aigfyxGo9RWhbacgZEuPEU3hl
         VlK0ZXnTdDsOaHT//t9wHOHSkTiBqktqYJyCbdJRdh6qTLY0Bt9uOxqnDfLGw6VvrwPd
         AQOMqYXSHlTURaUuwt5RpG42Gx1Q1h51qr1ACAKUSGVknUBZAO5nZz4rr0kgru/LmRDE
         xv7DcJX803PbsAX50TrwwzIzPoQaLchcpFtIo5Vx3BSfvWEInfUMWbdbk+VGZMgtDkX6
         ZqMg==
X-Gm-Message-State: APjAAAX0ASSxHq8rI7k4kVEKW0YXQ4S8POQriRD9DnpnPIN7/6cn9Jrm
        nWeUmdKTPMfAiiUmFx9jcIZS/WeG8N4=
X-Google-Smtp-Source: APXvYqyR5tmbOZUbpj3H4GNfZOFKCa63gG9el2rRLXQQLKM+5yWXHR5qANeVh/wG9vegnsmzJGXiIQ==
X-Received: by 2002:a2e:b009:: with SMTP id y9mr7572466ljk.185.1570137768710;
        Thu, 03 Oct 2019 14:22:48 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id q3sm773317ljq.4.2019.10.03.14.22.47
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 14:22:47 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id c195so2919177lfg.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2019 14:22:47 -0700 (PDT)
X-Received: by 2002:ac2:47f8:: with SMTP id b24mr6965481lfp.134.1570137766481;
 Thu, 03 Oct 2019 14:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <6a26185f-f188-0049-b153-1541d7a514b0@redhat.com>
In-Reply-To: <6a26185f-f188-0049-b153-1541d7a514b0@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Oct 2019 14:22:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=whf=vVVrmKb1rjfp1Y_57CRJjERsbYZ7+hnAWggF99zNw@mail.gmail.com>
Message-ID: <CAHk-=whf=vVVrmKb1rjfp1Y_57CRJjERsbYZ7+hnAWggF99zNw@mail.gmail.com>
Subject: Re: [PATCH] vfs: Fix EOVERFLOW testing in put_compat_statfs64
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 2, 2019 at 2:17 PM Eric Sandeen <sandeen@redhat.com> wrote:
>
> As a result, 32-bit userspace gets -EOVERFLOW for i.e. large file
> counts even with -D_FILE_OFFSET_BITS=64 set.

Applied.

           Linus
