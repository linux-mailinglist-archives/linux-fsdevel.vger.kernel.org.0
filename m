Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5412CB0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 18:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfE1QC7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 12:02:59 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33900 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfE1QC6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 12:02:58 -0400
Received: by mail-yw1-f68.google.com with SMTP id n76so8120510ywd.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2019 09:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4hIavdiZm9PxGhYq+27LqZLuCkdtSAzIfCxhy47vDhg=;
        b=cihtkg6fAHW+zeD4Dw/9JSpmZM38EQ7acdXml9JPkvhcL3H6X4wNQtpazQrvYPtwre
         e3jclgReD2mc8YmPKGdL5pB+1KVOuTQbJpLRX/Tpw416L7la5vwRzXWAhiy1jU173QGB
         XS9g36rB2GWAPNe/kxwSlB9/WqCsmCVtEn0vLq7SNIQl0ETHPoAp8zDT4Euij4T/3Se9
         bPokzUNsJMifK0rs/TVNZzTBDtROADimu2QHWHguvqcpmi2VjG2Yjxew7Ewyn8cofHfl
         M+rDLud0f6FfPQw5DM7GfUrYx7emhYGA+ENl5VJE3d0gjymUWjMse0/RZkZoiY5Zdbzw
         /Jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4hIavdiZm9PxGhYq+27LqZLuCkdtSAzIfCxhy47vDhg=;
        b=SyixwfgQi+t27xKlSACQ6a/qSot8EnJRHBbtDIDd1snRy/boN+I24qY0zkPDRl/Wfo
         Gst5y5UEhxfTJytHhrcywnrOCWnQG66y2BaKOyDBRHiw5BxMSM/P1CHZAquwj5n7cept
         OlHw0eXqSCyZo5p3sQ3MspS8OHB13pdB8tvVR9goYNjiWIWfAJLy+LeLBG++56mnMKg6
         s7CnifZCwBz2psOwJoCrPbSZ+3h9UJVg9KDJLegJp1yOa0E+86PwOd6oEt6jy65qOugo
         PD0G5TnGygK6IYTDul/zGiKKpfh42nl2bfuPzIrV6qACOIo6VN925xhbtIfPocC4oPLG
         t+wQ==
X-Gm-Message-State: APjAAAU/+3OdIzmwwn7vIxEwQM/4RXoSy1g/owAQjLzAQuv26PPPsDbV
        tLBtVTLZVWErzkPrzq8/shu5NaKGqmb8z4Evi68LsJbu
X-Google-Smtp-Source: APXvYqwyzBHc8jo3p4vI5jUsansmbNvXlU2tPFoXkEHpLqBFmrx14U6GS6qOb+yBSnsA7eZbDxukDYp9R7MMEAETFms=
X-Received: by 2002:a81:7096:: with SMTP id l144mr13129103ywc.294.1559059378098;
 Tue, 28 May 2019 09:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190516115619.18926-1-jack@suse.cz> <20190528155430.GA27155@quack2.suse.cz>
In-Reply-To: <20190528155430.GA27155@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 28 May 2019 19:02:46 +0300
Message-ID: <CAOQ4uxi7LKSxcmmbgBpLJgHZFVa56oupQRQvabL4EGM7jfp1mQ@mail.gmail.com>
Subject: Re: [PATCH v2] fanotify: Disallow permission events for proc filesystem
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 28, 2019 at 6:54 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 16-05-19 13:56:19, Jan Kara wrote:
> > Proc filesystem has special locking rules for various files. Thus
> > fanotify which opens files on event delivery can easily deadlock
> > against another process that waits for fanotify permission event to be
> > handled. Since permission events on /proc have doubtful value anyway,
> > just disallow them.
> >
> > Link: https://lore.kernel.org/linux-fsdevel/20190320131642.GE9485@quack2.suse.cz/
> > Signed-off-by: Jan Kara <jack@suse.cz>
>
> Amir, ping? What do you think about this version of the patch?

Sorry, I reviewed but forgot to reply.
You may add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.
