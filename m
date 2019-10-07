Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFA7CECBB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 21:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbfJGTYj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 15:24:39 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37239 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbfJGTYj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:24:39 -0400
Received: by mail-lf1-f68.google.com with SMTP id w67so10111765lff.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2019 12:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VUUs7b6PD8mcHjewbbum0tiJ7HoN2TPQShKmb2T5xhY=;
        b=WYlynf8xVO5LbzpJUIuvhqsohiHzM0zAN1btD4PdVDolJNn5Cjm+iynkHY3rtZiLHh
         ixmIHCJQWK03omwq1m6/B8gvANY//JkkapfhKwFxSnzpbJpcdDW8HdDmDOwC6lkvWvi5
         eq8n7gzdQvqVRNXNtbMAJ6QyKUe0Y8Oh/D37A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VUUs7b6PD8mcHjewbbum0tiJ7HoN2TPQShKmb2T5xhY=;
        b=EpRcdlSRB4LtGQ9SCw9MIpVIGHBpyvGIQCCldyH3POl9fIlBpVKmSpJ8IjA5YW8uZb
         E2IbVsl5RhTra+aN8zP+XKLyCeAS05DNSwJQiPanxsgI16SJv6VtxVfaD8N8M4eEw76b
         RQRtauan7iJX+bfE3A0bb5pAz8qsWYpfM2E53vjoHft7qzJxIrWkk01Wmy05I70ENocg
         K8qDmOQf7Ir4Ow0om41PtG6Wm/VmlDPc6EZEXEqjejL3BZSYO+EqA5wsi+7O5dlePv6I
         BXxwHYglPx3wu/tiIi3+Twf1f5zeebU0LQJlQ++cagYY2cNICmO6Ky6eiheowNW/QKp2
         5AUw==
X-Gm-Message-State: APjAAAVjsNc7pcrABYM2p6+YKpbapM9ifJs2WXo5NnpnrsjKXKrx2S8k
        sI9XkdbfJriLTJWrRH9YqjgXdUgQReY=
X-Google-Smtp-Source: APXvYqy799Px5BxPFInZbqSbDj7uymXT2orVo0PA3bjtUztfot+Z78YVaWgxZp63limXWOOyxwAKLg==
X-Received: by 2002:a05:6512:411:: with SMTP id u17mr7457350lfk.151.1570476276542;
        Mon, 07 Oct 2019 12:24:36 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id q124sm3361192ljb.28.2019.10.07.12.24.35
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 12:24:35 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id y23so14922869lje.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2019 12:24:35 -0700 (PDT)
X-Received: by 2002:a2e:551:: with SMTP id 78mr20008997ljf.48.1570476275275;
 Mon, 07 Oct 2019 12:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006b7bfb059452e314@google.com> <20191007190747.GA16653@gmail.com>
 <CAHk-=whtA4bWH=8xY8TAejDR4XyHDux0xH7_y-0jzft0XkvMfw@mail.gmail.com> <20191007191918.GD16653@gmail.com>
In-Reply-To: <20191007191918.GD16653@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Oct 2019 12:24:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjqU_k5Sai0Zvi4wACK7CqhhfhdMq8La30oq-8O=6H_yg@mail.gmail.com>
Message-ID: <CAHk-=wjqU_k5Sai0Zvi4wACK7CqhhfhdMq8La30oq-8O=6H_yg@mail.gmail.com>
Subject: Re: WARNING in filldir64
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     syzbot <syzbot+3031f712c7ad5dd4d926@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 7, 2019 at 12:19 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> So it seems to have generated a corrupt filesystem image and tried to mount it.

Ok, then everything is working as expected.

Let's ignore the syzbot one for now, and see if some other load triggers this.

             Linus
