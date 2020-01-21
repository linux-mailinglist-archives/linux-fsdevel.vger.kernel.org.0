Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08CCF143617
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 04:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgAUDzS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 22:55:18 -0500
Received: from mail-io1-f48.google.com ([209.85.166.48]:44153 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgAUDzS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 22:55:18 -0500
Received: by mail-io1-f48.google.com with SMTP id b10so1314036iof.11;
        Mon, 20 Jan 2020 19:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=A4tDUIGRmfMPIKlyexLTrGsvOihJxfhsquzCv2ViF0c=;
        b=va2tkpi6L71ioWs27G3qEUMLYaraNLXkvXwkhtxBc/JRduz6BMOq6Loo0yRPvdoi7c
         jqzsG2PGCrYlgh7lvNCf9tq2yVP9aT37U5AaZCcXIq0nNief8Hy8QP9xeV40YyZdc8Ah
         O1WpvYwIXbYCtwCqwogr74LsvZgUqJYwluCvTgVIfFf+0MXbFZaJ+3JC+LhEzR4dWENr
         WJU+TRv/w2pRPqIiwzMqKwpkPQzXxWZ1ZTovR0dZXWycpSKoksZHTOQ3HQB6DkRN86rb
         cU35jHGRR+t28c73gKD2jxDhKrYOQDN3Y/KKhlAwH58il2cXOGjklOZyPedeM+BV9yxH
         Ly0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=A4tDUIGRmfMPIKlyexLTrGsvOihJxfhsquzCv2ViF0c=;
        b=saqdJv8AHl3tlCqLStvnlu7amxgtF8ghg0kBvWEp8OqdhcUYg3L6d42YxvQd8RZyhT
         UF5fXfzLta96GFBFfAkMpSKgAYuuhHj5SFMwQ8jjpGaQDe14RPSW75YvkdHXVGixRTi/
         B6fGANHyuPSALhjZCQNF6D4BxjxpZKl2MiLRQ9mEIYSgp6bw8BypY3gNvUhDXkf3K5h4
         hS1boknonSqDstnxRmwUmPIf7Z5ssWu6CqMYmBGYpylG7ghSIlOQF3Hs73phouwXhde9
         WhfzP4duXTimNTh9xmxXCKBnotsBgyTT0w9X8SjbDzXmpggtAxwlK3qA4if0BeMdTM92
         zJQQ==
X-Gm-Message-State: APjAAAUCRdVXCX6sG04sYqVGhcGzWTZipzikFFreGbV62FW0okP7KPK5
        iiNYls5me7fkUIlON87s1/0gyJ7AgqT0YBsRLhvti/J+1VA=
X-Google-Smtp-Source: APXvYqxcIn8DniNQJStIEFSLLJoSkZuZDAanME5mwJ0UM/0eRf98+lLJwHIXq8ODvZ36D2Yhj1f06vViWDC2c3KEn/s=
X-Received: by 2002:a02:2446:: with SMTP id q6mr1779382jae.78.1579578917548;
 Mon, 20 Jan 2020 19:55:17 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 20 Jan 2020 21:55:06 -0600
Message-ID: <CAH2r5mvUmZca8TRVsyZvrB_Loeeo4Kd8T7rHw5s6iaN=yC+O_Q@mail.gmail.com>
Subject: [LFS/MM TOPIC] Enabling file and directory change notification for
 network and cluster file systems
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently the inotify interface in the kernel can only be used for
local file systems (unlike the previous change notify API used years
ago, and the change notify interface in Windows and other OS which is
primarily of interest for network file systems).

I wanted to discuss the VFS changes needed to allow inotify requests
to be passed into file systems so network and cluster file systems (as
an example in the SMB3 case this simply means sending a
SMB3_CHANGE_NOTIFY request to the server, whether Samba or Cloud
(Azure) or Mac or Windows or Network Appliance - all support the API
on the server side, the problem is that the network or cluster fs
client isn't told about the request to wait on the inotify event).
Although user space tools can use file system specific ioctls to wait
on events, it is obviously preferable to allow network and cluster
file systems to wait on events using the calls which current Linux
GUIs use.

This would allow gnome file manager GUI for example to be
automatically updated when a file is added to an open directory window
from another remote client.

It would also fix the embarrassing problem noted in the inotify man page:

"Inotify  reports  only events that a user-space program triggers
through the filesystem
       API.  As a result, it does not catch remote events that occur
on  network  filesystems."

but that is precisely the types of notifications that are most useful
... users often are aware of updates to local directories from the
same system, but ... automatic notifications that allow GUIs to be
updated on changes from **other** clients is of more value (and this
is exactly what the equivalent API allows on other OS).

The changes to the Linux VFS are small.


-- 
Thanks,

Steve
