Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98C34A9DF3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 11:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733083AbfIEJN0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 05:13:26 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:43408 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732345AbfIEJN0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 05:13:26 -0400
Received: by mail-lj1-f170.google.com with SMTP id d5so1619584lja.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Sep 2019 02:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lg+YMpq+gNDI7xAM1SDSvOeQlpL3bUFXipKQWY1s63k=;
        b=shXHw/QY1ASWgitkU/tyiV7VOOMF7hyYLjT/iDUwItxDaP1N7LClS0e8XHmU+qY8W1
         9fdyt2mAYLROze4tMA1n7IKnlShLUrDVatCS0Tf6bsDIqs0wLlrmbe3LZE7DvEjYpIG1
         F2H7V0ziSg7Y3DLAjPmYr9TmkRgQvjUVxVW/C0UyQ1BM109wmTUmuappdobvU1Os1ZE+
         fthm3RK517nRHJTaFe+RS5LNydSxIFe+aoCxTZhndemSRkm5FTpBOjG2F0rUpOgRqH/M
         oa1R0RY6KpeXYbSeMamG1o9o9b4L5pUVWr4Q6IwP4JCCUoywOk3RJhVsYzxVCiGHnN38
         xK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lg+YMpq+gNDI7xAM1SDSvOeQlpL3bUFXipKQWY1s63k=;
        b=POo/Kr5Fuhrq5AUtZYk4hJNj7VFMu4jT0Uy1jTzE8C9jbMVH1wYx2jy/66rdlC1fwo
         2YiF71P4fzTu4omVZTNtEA5VOtcAufEkU2WzQd49DpNd4iuLN4kcz6eXxczCThyIf9Ow
         kNZ4bKHbi9pgxNujeag2x/b64aW7wgE/4lggBUOwRfcrzRJHIUQMGzkSwo5QM+5/zvz6
         UfCjQkYPVZa/mruVCKh57aGUNB+LeQ2Ik/NlVgPexlPDHUr+DPdobcIp9KOV678P7N41
         buafU63iLlNb+mRq16iyBNX3tgHbD8fcGqMLXe81wfWj1RtBTmzS5a1ttaHbI+goeE1a
         r6rA==
X-Gm-Message-State: APjAAAVsEGIvp0hepeQsvK6NsvMLtMS5Ao0EdIuCsoZOnk8AiJJt10Gw
        vxGxWMw4XMugdLvwqnAu+UafUXZcrkifF4B4eM9ouw==
X-Google-Smtp-Source: APXvYqxs7StB/zHZBT6cbVWDGsXZppnf8u0EPpozPSsrwy7Sjyo5pTckCUC8G6y1E9FCq8UFjNZWbaplA6eKwnLCr/M=
X-Received: by 2002:a2e:94cd:: with SMTP id r13mr1349759ljh.24.1567674804268;
 Thu, 05 Sep 2019 02:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <7C6CCE98-1E22-433C-BF70-A3CBCDED4635@lca.pw> <20190903123719.GF1131@ZenIV.linux.org.uk>
 <20190903130456.GA9567@infradead.org> <20190903134832.GH1131@ZenIV.linux.org.uk>
 <20190903135024.GA8274@infradead.org> <20190903135354.GI1131@ZenIV.linux.org.uk>
 <20190903153930.GA2791@infradead.org> <20190903175610.GM1131@ZenIV.linux.org.uk>
 <20190904123940.GA24520@infradead.org>
In-Reply-To: <20190904123940.GA24520@infradead.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 5 Sep 2019 14:43:12 +0530
Message-ID: <CA+G9fYtwEfp482+8qzGKD9NSHOGtKyp4pKbVxQK8G4L94UvOVQ@mail.gmail.com>
Subject: Re: "fs/namei.c: keep track of nd->root refcount status" causes boot panic
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Qian Cai <cai@lca.pw>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph and Al Viro,

Linux next 20190904 boot PASS now.
May i know which patch fixed this problem ?

- Naresh
